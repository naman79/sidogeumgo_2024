
/**
 * VerticalTranspose v1
 * - rows(JSON[]) + fields(string[]) -> 전치 -> vDS(DataList) 생성/적용(있으면)
 * - WebSquare가 없으면(또는 미로딩) 전치 결과 객체만 반환
 */
(function(global){
  function ensureArray(x){ return Array.isArray(x) ? x : (x ? [x] : []); }
  function toStringSafe(v){ return v==null ? "" : String(v); }

  /** 전치: rows[{...}] -> { fields[], cols[] }
   * cols[k] = { raw: rows[k], values: fields.map(f=>rows[k][f]) }
   */
  function transpose(rows, fieldOrder){
    if (!rows || !rows.length) return { fields: [], cols: [] };
    const fields = (fieldOrder && fieldOrder.length) ? fieldOrder : Object.keys(rows[0]);
    const cols = rows.map((r) => ({ raw: r, values: fields.map(f => r[f]) }));
    return { fields, cols };
  }

  /** vDS(payload) 구성: { colIds[], dataRows[] }
   * colIds = ["C1".."CN"], dataRows[r] = {C1:..,C2:..}
   */
  function buildVdsPayload(transposed){
    const { fields, cols } = transposed;
    const colIds = cols.map((_,i)=>"C"+(i+1));
    const dataRows = fields.map((_,rIdx)=>{
      const rowObj = {};
      for (let c=0;c<cols.length;c++) rowObj["C"+(c+1)] = toStringSafe(cols[c].values[rIdx]);
      return rowObj;
    });
    return { colIds, dataRows };
  }

  /** WebSquare 존재 시: DataList 생성/갱신 */
  function applyToWebSquareGrid({ gridId, vdsId, keyField="id", colWidth=140 }, transposed){
    if (!(global.$p && typeof $p.getComponentById==="function")) {
      return { applied:false, reason:"WebSquare not detected" };
    }
    const grid = $p.getComponentById(gridId);
    if (!grid) return { applied:false, reason:"grid not found: "+gridId };

    // vDS 확보
    let vds = $p.getComponentById(vdsId);
    if (!vds) vds = $p.createDataList(vdsId);

    // 1) columnInfo 재정의
    const { colIds, dataRows } = buildVdsPayload(transposed);
    vds.setColumnInfo([]);                      // reset
    colIds.forEach(id => vds.addColumn(id,"text"));

    // 2) data 채우기
    vds.setData([]);
    dataRows.forEach(r => vds.addRow(r));

    // 3) grid 컬럼 헤더(원본 레코드 키표시)
    const colInfos = transposed.cols.map((c, i) => ({
      id: "C"+(i+1),
      name: c.raw && (c.raw[keyField] ?? ("#"+(i+1))),
      width: colWidth, align: "left"
    }));

    grid.setDataList(vds);
    grid.setColumnInfo(colInfos);
    // 왼쪽 행 헤더 = 필드명
    grid.setRowHeader({ show:true, width:160, valueFunction: function(row){ return transposed.fields[row]; } });

    return { applied:true, vdsId, colCount: colIds.length, rowCount: dataRows.length };
  }

  /** 편의 함수: DS -> rows 추출(가능하면 WebSquare API 사용) */
  function extractRowsFromDS(dsId){
    if (!(global.$p && typeof $p.getComponentById==="function")) return null;
    const ds = $p.getComponentById(dsId);
    if (!ds) return null;
    if (typeof ds.getAllJSON === "function") return ds.getAllJSON();
    if (typeof ds.getMatchedJSON === "function") return ds.getMatchedJSON();
    // fallback (열이름 기반 수집)
    const cols = (typeof ds.getColumnNames === "function") ? ds.getColumnNames() : [];
    const rc = (typeof ds.getRowCount === "function") ? ds.getRowCount() : 0;
    const out = [];
    for (let r=0;r<rc;r++){
      const o={};
      for (let i=0;i<cols.length;i++) o[cols[i]] = ds.getCellData(r, cols[i]);
      out.push(o);
    }
    return out;
  }

  /** 고수준 API: DS -> 전치 -> grid에 적용 + 원본 DS 이벤트 구독(자동 갱신) */
  function wireDatasetToVerticalGrid({ dsId, gridId, vdsId="vds_vertical", fields, keyField="id", colWidth=140 }){
    const toRows = () => extractRowsFromDS(dsId) || [];
    const rebuild = () => {
      const t = transpose(toRows(), ensureArray(fields));
      return applyToWebSquareGrid({ gridId, vdsId, keyField, colWidth }, t);
    };
    const res = rebuild();

    // DS 변경 이벤트 구독 (있을 때만)
    if (global.$p) {
      const ds = $p.getComponentById(dsId);
      const safeAdd = (e,h)=>{ try{ ds.addEventHandler(e,h);}catch(_){ } };
      if (ds) {
        safeAdd("onLoadCompleted", rebuild);
        safeAdd("onDataChanged",   rebuild);
        safeAdd("onRowPosChanged", rebuild);
      }
    }
    return res;
  }

  // 노출
  global.VerticalTranspose = {
    transpose,            // (rows, fieldOrder?) -> {fields, cols}
    buildVdsPayload,      // (transposed) -> {colIds, dataRows}
    applyToWebSquareGrid, // ({gridId, vdsId, keyField?, colWidth?}, transposed) -> {applied,...}
    extractRowsFromDS,    // (dsId) -> rows[]
    wireDatasetToVerticalGrid // 고수준 one-liner
  };
})(window);

