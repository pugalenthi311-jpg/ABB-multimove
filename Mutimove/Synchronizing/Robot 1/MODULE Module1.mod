MODULE Module1
    CONST robtarget Target_10:=[[999.999898295,1871.827951571,1200.499961856],[0.35355338,0.612372463,0.612372431,-0.353553363],[-1,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_20:=[[-999.99990679,1871.827854987,1200.499972862],[0.353553457,0.612372443,0.612372423,-0.353553334],[-2,-2,1,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_30:=[[-999.999854129,1871.827915285,1800.499900037],[0.353553432,0.612372491,0.612372429,-0.353553266],[-2,-2,1,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_40:=[[1000.000037448,1871.827969874,1800.499909368],[0.35355343,0.612372548,0.612372412,-0.353553198],[-1,-3,2,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
        VAR syncident syncIdentWaitSync;
        VAR syncident syncIdentSyncMoveOn;
        VAR syncident syncIdentSyncMoveOff;
        PERS tasks taskListAll{2}:=[["T_ROB1"],["T_ROB2"]];
PROC main()
	ConfL\Off;
	WaitSyncTask syncIdentWaitSync,taskListAll;
	SyncMoveOn syncIdentSyncMoveOn,taskListAll;
	Path_10;
	SyncMoveOff syncIdentSyncMoveOff;
ENDPROC
    PROC Path_10()
        MoveL Target_10,v1000,z100,tool0\WObj:=wobj0;
        MoveL Target_20,v1000,z100,tool0\WObj:=wobj0;
        MoveL Target_30,v1000,z100,tool0\WObj:=wobj0;
        MoveL Target_40,v1000,z100,tool0\WObj:=wobj0;
        MoveL Target_10,v1000,z100,tool0\WObj:=wobj0;
    ENDPROC
ENDMODULE