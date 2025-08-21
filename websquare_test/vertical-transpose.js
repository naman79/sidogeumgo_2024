
/**
 * vertical-transpose.js
 * - 로딩시 아무 일도 안 함
 * - initVerticalTranspose() 호출하면 window.VerticalTranspose에 유틸 등록
 */
function initVerticalTranspose(global) {
  if (!global) global = window;

  function ensureArray(x) {
    return Array.isArray(x) ? x : (x ? [x] : []);
  }

  function toStringSafe(v) {
    return v == null ? "" : String(v);
  }

  /** JSON 배열을 전치 (행=필드, 열=레코드) */
  function transpose(rows, fieldOrder) {
    if (!rows || !rows.length) return { fields: [], cols: [] };
    var fields = (fieldOrder && fieldOrder.length) ? fieldOrder : Object.keys(rows[0]);
    var cols = rows.map(function(r) {
      return { raw: r, values: fields.map(function(f){ return r[f]; }) };
    });
    return { fields: fields, cols: cols };
  }

  /** vDS용 payload 구성 */
  function buildVdsPayload(transposed) {
    var fields = transposed.fields;
    var cols = transposed.cols;
    var colIds = cols.map(function(_, i){ return "C" + (i+1); });
    var dataRows = fields.map(function(_, rIdx){
      var rowObj = {};
      for (var c=0; c<cols.length; c++) {
        rowObj["C"+(c+1)] = toStringSafe(cols[c].values[rIdx]);
      }
      return rowObj;
    });
    return { colIds: colIds, dataRows: dataRows };
  }

  /** WebSquare Grid에 적용 */
  function applyToWebSquareGrid(config, transposed) {
    var gridId   = config.gridId;
    var vdsId    = config.vdsId;
    var keyField = config.keyField || "id";
    var colWidth = config.colWidth || 140;

    if (!(global.$p && typeof $p.getComponentById === "function")) {
      return { applied:false, reason:"WebSquare not detected" };
    }
    var grid = $p.getComponentById(gridId);
    if (!grid) return { applied:false, reason:"grid not found: " + gridId };

    var vds = $p.getComponentById(vdsId);
    if (!vds) vds = $p.createDataList(vdsId);

    var payload = buildVdsPayload(transposed);
    var colIds = payload.colIds;
    var dataRows = payload.dataRows;

    vds.setColumnInfo([]);
    colIds.forEach(function(id){ vds.addColumn(id,"text"); });

    vds.setData([]);
    dataRows.forEach(function(r){ vds.addRow(r); });

    var colInfos = transposed.cols.map(function(c, i){
      return {
        id: "C"+(i+1),
        name: c.raw && (c.raw[keyField] != null ? c.raw[keyField] : ("#"+(i+1))),
        width: colWidth,
        align: "left"
      };
    });

    grid.setDataList(vds);
    grid.setColumnInfo(colInfos);
    grid.setRowHeader({
      show:true,
      width:160,
      valueFunction: function(row){ return transposed.fields[row]; }
    });

    return { applied:true, vdsId:vdsId, colCount:colIds.length, rowCount:dataRows.length };
  }

  /** DataList/Collection → JSON rows */
  function extractRowsFromDS(dsId) {
    if (!(global.$p && typeof $p.getComponentById === "function")) return null;
    var ds = $p.getComponentById(dsId);
    if (!ds) return null;
    if (typeof ds.getAllJSON === "function") return ds.getAllJSON();
    if (typeof ds.getMatchedJSON === "function") return ds.getMatchedJSON();

    var cols = (typeof ds.getColumnNames === "function") ? ds.getColumnNames() : [];
    var rc = (typeof ds.getRowCount === "function") ? ds.getRowCount() : 0;
    var out = [];
    for (var r=0; r<rc; r++) {
      var o = {};
      for (var i=0; i<cols.length; i++) {
        o[cols[i]] = ds.getCellData(r, cols[i]);
      }
      out.push(o);
    }
    return out;
  }

  /** DS와 Grid를 연결해 전치 표시 */
  function wireDatasetToVerticalGrid(config) {
    var dsId    = config.dsId;
    var gridId  = config.gridId;
    var vdsId   = config.vdsId || "vds_vertical";
    var fields  = config.fields;
    var keyField= config.keyField || "id";
    var colWidth= config.colWidth || 140;

    function toRows(){ return extractRowsFromDS(dsId) || []; }
    function rebuild(){
      var t = transpose(toRows(), ensureArray(fields));
      return applyToWebSquareGrid({ gridId:gridId, vdsId:vdsId, keyField:keyField, colWidth:colWidth }, t);
    }

    var res = rebuild();

    if (global.$p) {
      var ds = $p.getComponentById(dsId);
      function safeAdd(ev, h){ try{ ds.addEventHandler(ev, h); }catch(e){} }
      if (ds) {
        safeAdd("onLoadCompleted", rebuild);
        safeAdd("onDataChanged",   rebuild);
        safeAdd("onRowPosChanged", rebuild);
      }
    }
    return res;
  }

  // 글로벌 등록
  global.VerticalTranspose = {
    transpose: transpose,
    buildVdsPayload: buildVdsPayload,
    applyToWebSquareGrid: applyToWebSquareGrid,
    extractRowsFromDS: extractRowsFromDS,
    wireDatasetToVerticalGrid: wireDatasetToVerticalGrid
  };

  return global.VerticalTranspose;
}

