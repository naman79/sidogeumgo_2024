import java.io.*;
import java.util.ArrayList;
import java.util.List;

//TIP 코드를 <b>실행</b>하려면 <shortcut actionId="Run"/>을(를) 누르거나
// 에디터 여백에 있는 <icon src="AllIcons.Actions.Execute"/> 아이콘을 클릭하세요.
public class Main {
    public static void main(String[] args) {
        DataDiffRunner runner = new DataDiffRunner();
        runner.runDiff(
                "c:\\Users\\admin\\Downloads\\unyong_info_20250428_20250429012515.dat",
                "c:\\Users\\admin\\Downloads\\unyong_info_20250425_20250426012520.dat",
                "EUC-KR");
    }
}