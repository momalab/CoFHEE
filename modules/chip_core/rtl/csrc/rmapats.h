#ifndef __DO_RMAHDR_

#ifdef __cplusplus
  extern "C" {
#endif

typedef unsigned long UP;
typedef unsigned U;
typedef unsigned char UB;
typedef unsigned short US;
typedef unsigned char SVAL;
typedef unsigned char TYPEB;
typedef unsigned char scalar;
typedef struct vec32 vec32;
typedef struct qird QIRD;
typedef unsigned char UST_e;
typedef unsigned uscope_t;
typedef U  NumLibs_t;
struct vec32 {
    U  I1;
    U  I2;
};
typedef unsigned RP;
typedef unsigned RO;
typedef unsigned short HsimEdge;
typedef unsigned char HsimExprNode;
typedef union {
    double I464;
    unsigned long long I447;
    unsigned  I465[2];
} rma_clock_struct;
typedef struct eblk EBLK;
typedef int (* E_fn)(void);
struct eblk {
    struct eblk * I452;
    E_fn  I453;
    struct iptmpl * I454;
    unsigned I462;
    struct eblk * I463;
};
typedef struct {
    RP  I452;
    RP  I453;
    RP  I454;
    unsigned I462;
    RP  I463;
} RmaEblk;
typedef union {
    double I464;
    unsigned long long I447;
    unsigned  I465[2];
} clock_struct;
typedef clock_struct  RmaClockStruct;
typedef enum {
    PD_SING = 0,
    PD_RF = 1,
    PD_PLSE = 2,
    PD_PLSE_RF = 3,
    PD_NULL = 4
} PD_e;
typedef struct RmaRetain_t RmaRetain;
struct RmaRetain_t {
    RmaEblk  I451;
    RP  I476;
    RP  I477;
    U  I478;
    US  I479 :1;
    US  I480 :4;
    US  newval :2;
    US  I482 :2;
    US  I162 :2;
};
typedef struct RmaMPSched RmaMps;
struct RmaMPSched {
    scalar  I484;
    scalar  I485;
    US  I486 :9;
    US  fHsim :1;
    US  I162 :6;
    RP  I488;
    RmaEblk  I489;
    RP  I490;
    RP   I491[1];
};
typedef struct RmaMPSchedPulse RmaMpsp;
struct RmaMPSchedPulse {
    scalar  I484;
    scalar  I485;
    US  I486 :10;
    US  I162 :6;
    RP  I488;
    RmaEblk  I489;
    scalar  I493;
    scalar  I494;
    scalar  I495;
    scalar  I496;
    U  I497;
    RmaClockStruct  I498;
    RmaClockStruct  I499;
    U  state;
    U  I501;
    RP  I454;
    RP  I502;
    RP  I503;
    RP   I491[1];
};
typedef struct {
    RmaEblk  I451;
    RP  I504;
    scalar  I505;
    scalar  I493;
    scalar  I506;
} RmaTransEventHdr;
typedef struct red_t {
    U  I507;
    U  I508;
    U  I509;
} RED;
typedef struct predd {
    PD_e  I162;
    RED   I510[1];
} PREDD;
typedef unsigned long long ULL;
typedef struct {
    RP  I511;
    RP  I502;
    RP  I454;
    RP  I503;
    RmaEblk  I451;
    RmaEblk  I512;
    RP  I513;
    scalar  I505;
    scalar  I493;
    char state;
    uscope_t  I514;
    U  I515;
    RP  I516;
    scalar  I494;
    scalar  I495;
    scalar  I496;
    RmaClockStruct  I498;
    RmaClockStruct  I499;
    RP  I490;
} RmaPulse;
typedef U  FlatNodeNum;
typedef U  InstNum;
typedef enum {
    QIRDModuleC = 1,
    QIRDSVPackageC = 2
} QIRDModuleType;
typedef struct {
    U  I517 :1;
    U  I518 :1;
    U  I519 :1;
    U  I520 :1;
    U  I521 :1;
    U  I522 :1;
    U  I523 :1;
    U  I524 :1;
    U  I525 :1;
    U  I526 :1;
    U  I527 :1;
    U  I528 :1;
    U  I529 :1;
    U  I530 :1;
    U  I531 :1;
    U  I532 :1;
    U  I533 :1;
    U  I534 :1;
    U  I535 :1;
    U  I536 :1;
    QIRDModuleType  I537 :2;
    U  I538 :1;
    U  I539 :1;
    U  I540 :1;
    U  I541 :1;
    U  I542 :1;
    U  I543 :1;
    U  I544 :1;
    U  I545 :1;
    U  I546 :1;
    U  I547 :1;
} BitFlags;
struct qird {
    US  I4;
    US  I5;
    U  I6;
    U  I7;
    char * I8;
    char * I9;
    U  * I10;
    char * I11;
    U  I12;
    U  I13;
    struct vcd_rt * I14;
    U  I16;
    struct _vcdOffset_rt * I17;
    U  I19;
    U  I20;
    U  * I21;
    U  * I22;
    void * I23;
    U  I24;
    int I25;
    UP  I26;
    U  I27;
    U  I28;
    U  I29;
    UP  I30;
    U  * I31;
    BitFlags  I32;
    U  I33;
    U  I34;
    U  I35;
    U  * I36;
    U  I37;
    U  I38;
    U  I39;
    U  I40;
    U  I41;
    U  I42;
    U  * I43;
    U  I44;
    U  * I45;
    U  I46;
    U  * I47;
    U  I48;
    U  I49;
    U  I50;
    U  I51;
    U  I52;
    U  * I53;
    U  I54;
    U  I55;
    U  I56;
    U  I57;
    U  * I58;
    U  I59;
    U  * I60;
    U  I61;
    U  I62;
    U  I63;
    U  I64;
    U  I65;
    U  I66;
    U  I67;
    U  * I68;
    char * I69;
    U  I70;
    U  I71;
    U  I72;
    U  I73;
    U  I74;
    U  * I75;
    U  I76;
    U  I77;
    U  I78;
    UP  * I79;
    U  I80;
    U  I81;
    U  I82;
    U  I83;
    U  I84;
    U  I85;
    U  * I86;
    U  I87;
    U  I88;
    U  * I89;
    U  * I90;
    U  * I91;
    U  * I92;
    U  * I93;
    U  I94;
    U  I95;
    struct taskInfo * I96;
    U  I98;
    U  I99;
    int * I100;
    U  I101;
    U  I102;
    U  I103;
    U  I104;
    U  I105;
    struct qrefer * I106;
    U  * I108;
    unsigned * I109;
    void * I110;
    U  I111;
    U  I112;
    U  I113;
    U  I114;
    U  * I115;
    U  I116;
    U  * I117;
    U  I118;
    U  I119;
    U  I120;
    U  * I121;
    U  I122;
    U  * I123;
    U  I124;
    U  I125;
    U  * I126;
    U  I127;
    U  I128;
    U  * I129;
    U  * I130;
    U  * I131;
    U  I132;
    U  I133;
    U  I134;
    U  I135;
    U  I136;
    struct qrefee * I137;
    U  * I139;
    U  I140;
    struct qdefrefee * I141;
    U  * I143;
    int (* I144)(void);
    char * I145;
    U  I146;
    U  I147;
    void * I148;
    NumLibs_t  I149;
    char * I150;
    U  * I151;
    U  I152;
    U  I153;
    U  I154;
    U  I155;
    U  I156;
    U  * I157;
    U  * I158;
    int I159;
    struct clock_load * I160;
    int I175;
    struct clock_data * I176;
    int I192;
    struct clock_hiconn * I193;
    U  I197;
    int I198;
    U  I199;
    int I200;
    U  * I201;
    U  * I202;
    U  I203;
    void * I204;
    U  I205;
    U  I206;
    UP  * I207;
    void * I208;
    U  I209;
    UP  * I210;
    U  * I211;
    int (* I212)(void);
    U  * I213;
    UP  * I214;
    U  * I215;
    U  I216;
    U  I217;
    U  I218;
    UP  * I219;
    U  * I220;
    U  I221 :1;
    U  I222 :1;
    U  I223 :30;
    UP  * I224;
    UP  * I225;
    U  * I226;
    U  * I227;
    UP  * I228;
    UP  * I229;
    UP  * I230;
    U  * I231;
    UP  * I232;
    UP  * I233;
    U  I234;
    UP  * I235;
    U  I236;
    U  I237;
    U  I238;
    int (* I239)(void);
    struct daidirInfo * I240;
    struct vcs_tftable * I242;
    U  I244;
    UP  (* I245)(void);
    UP  (* I246)(void);
    UP  (* I247)(void);
    UP  (* I248)(void);
    int * I249;
    int (* I250)(void);
    char * I251;
    UP  * I252;
    UP  * I253;
    int (* I254)(void);
    int * I255;
    U  * I256;
    void * I257;
    U  I258;
    U  I259;
    U  I260;
    U  I261;
    U  I262;
    U  I263;
    UP  * I264;
    U  * I265;
    U  * I266;
    U  I267 :15;
    U  I268 :14;
    U  I269 :1;
    U  I270 :1;
    U  I271 :1;
    U  I272 :3;
    U  I273 :1;
    U  I274 :28;
    struct scope * I275;
    U  I277;
    U  I278;
    U  * I279;
    U  * I280;
    U  * I281;
    U  I282;
    U  I283;
    U  I284;
    struct pcbt * I285;
    U  I294;
    U  I295;
    void * I296;
    int I297;
    U  I298;
    U  I299;
    U  I300;
    U  I301;
    U  I302;
    void * I303;
    UP  * I304;
    U  I305;
    U  I306;
    void * I307;
    U  I308;
    void * I309;
    U  I310;
    void * I311;
    U  I312;
    int (* I313)(void);
    int (* I314)(void);
    void * I315;
    void * I316;
    void * I317;
    U  I318;
    U  I319;
    char * I320;
    U  I321;
    U  * I322;
    U  I323;
    U  * I324;
    U  I325;
    U  I326;
    U  I327;
    U  I328;
    U  I329;
    U  I330;
    U  * I331;
    U  I332;
    U  I333;
    U  * I334;
    U  I335;
    U  * I336;
    char * I337;
    U  I338;
    U  I339;
    U  I340;
    U  I341;
    U  * I342;
    U  I343;
    U  I344;
    struct cosim_info * I345;
    U  I347;
    U  * I348;
    U  I349;
    U  I350;
    U  * I351;
    U  I352;
    U  * I353;
    U  I354;
    U  I355;
    U  * I356;
    U  I357;
    U  I358;
    U  I359;
    U  * I360;
    U  I361;
    U  I362;
    U  I363;
    U  I364;
    U  I365;
    U  I366;
    U  I367;
    U  I368;
    U  * I369;
    U  * I370;
    void (* I371)(void);
    U  * I372;
    UP  * I373;
    struct mhdl_outInfo * I374;
    UP  * I376;
    U  I377;
    UP  * I378;
    U  I379;
    void * I380;
    U  * I381;
    void * I382;
    U  I383;
    U  I384;
    void * I385;
    void * I386;
    U  * I387;
    U  * I388;
    U  * I389;
    U  * I390;
    void * I391;
    U  I392;
    void * I393;
    U  * I394;
    char * I395;
    int (* I396)(void);
    U  * I397;
    char * I398;
    char * I399;
    U  I400;
    U  * I401;
    struct regInitInfo * I402;
    UP  * I404;
    U  * I405;
    char * I406;
    U  I407;
    U  I408;
    U  I409;
    U  I410;
    U  I411;
    U  I412;
    U  I413;
    U  * I414;
    U  * I415;
    U  I416;
    U  I417;
    U  I418;
    UP  * I419;
    U  I420;
    UP  * I421;
    UP  I422;
    UP  I423;
    U  I424;
    U  I425;
    U  * I426;
    U  * I427;
    UP  * I428;
    UP  * I429;
    void * I430;
    UP  I431;
    U  I432;
    U  I433;
    U  I434;
    U  I435;
    U  * I436;
    U  I437;
    U  * I438;
    U  I439;
    U  I440;
    U  * I441;
};
typedef struct pcbt {
    U  * I287;
    UP  I288;
    U  I289;
    U  I290;
    U  I291;
    U  I292;
    U  I293;
} PCBT;
struct iptmpl {
    QIRD  * I456;
    struct vcs_globals_t * I457;
    void * I459;
    UP  I460;
    UP  I461;
    struct iptmpl * I454[2];
};
typedef unsigned long long FileOffset;
typedef struct _hsimPeriodL {
    char  I562[256];
    struct _hsimPeriodL * I548;
} HsimPeriodL;
typedef struct {
    U   I564[2];
    U  I565 :1;
    U  I566 :1;
    U  I567 :8;
    U  I568 :8;
    U  I569 :8;
    U  I570 :4;
    unsigned long long I571;
    unsigned long long I572;
    unsigned long long I573;
    unsigned long long I574;
    unsigned long long I575;
    U  I576;
    U  I577;
    U  I578;
    U  I579;
    HsimPeriodL  * I580;
    HsimPeriodL  * I581;
    U  I582;
} HsimSignalMonitor;
typedef struct {
    scalar  I583;
    U  I584;
    U  I585;
    U  I586;
    U  I587;
    U  I588;
    U  I589;
    U  I590;
    HsimSignalMonitor  * I591;
    long long I592;
    U  I593;
    FlatNodeNum  I594;
    InstNum  I595;
} HsimNodeRecord;
typedef struct {
    RP  I596;
    RP  I454;
} RmaIbfIp;
typedef struct {
    RP  I596;
    RP  I597;
} RmaIbfPcode;
typedef struct {
    RmaEblk  I451;
    RP  I598;
    vec32  I599;
} RmaAnySchedVCg;
typedef struct {
    RmaEblk  I451;
    RP  I598;
    vec32   I600[1];
} RmaAnySchedWCg;
typedef struct {
    RmaEblk  I451;
    RP  I598;
    scalar   I601[1];
} RmaAnySchedECg;
typedef struct {
    RP  I602;
} RmaRootCbkCg;
typedef struct {
    U  I603;
} RmaRootVcdCg;
typedef struct {
    RP  I604;
} RmaRootForceCbkCg;
typedef struct {
    RmaEblk  I451;
    RP  I597;
    U   I445[1];
} RmaBitEdgeEblk;
typedef struct {
    U  I5;
    RP  I510;
    RmaEblk  I451;
    RmaIbfPcode  I608;
} RmaGateDelay;
typedef struct {
    U  I5;
    union {
        RP  I732;
        RP  I837;
        RP  I843;
    } I476;
    RmaIbfPcode  I608;
} RmaMPDelay;
typedef struct {
    U  I5;
    RmaPulse  I609;
    RmaIbfPcode  I608;
} RmaMPPulseHybridDelay;
typedef struct {
    U  I5;
    RmaIbfPcode  I608;
    RmaMps  I610;
} RmaMPHybridDelay;
typedef struct {
    U  I5;
    U  I611;
    RmaIbfPcode  I608;
    RmaEblk  I489;
} RmaMPHybridDelayPacked;
typedef struct {
    U  I5;
    RmaMpsp  I612;
    RmaIbfPcode  I608;
} RmaMPPulseOptHybridDelay;
typedef struct {
    U  I5;
    U  I509;
    RmaTransEventHdr  I549;
    RP  I613;
    RmaIbfPcode  I608;
} RmaNtcTransDelay;
typedef struct {
    U  I5;
    U  I509;
    RmaEblk  I451;
    RmaIbfPcode  I608;
} RmaNtcTransMpwOptDelay;
typedef struct {
    U  I5;
    RmaEblk  I451;
    RmaIbfPcode  I608;
} RmaNtcTransZeroDelay;
typedef struct {
    U  I5;
    U  I614;
    U  I615;
    RmaTransEventHdr  I549;
    RP  I613;
    RmaIbfPcode  I608;
} RmaNtcTransDelayRF;
typedef struct {
    U  I5;
    U  I614;
    U  I615;
    RmaEblk  I451;
    RmaIbfPcode  I608;
} RmaNtcTransMpwOptDelayRF;
typedef struct {
    U  I5;
    RP  I510;
    RmaEblk  I451;
    RmaIbfPcode  I608;
} RmaICSimpleDelay;
typedef struct {
    U  I5;
    union {
        RP  psimple;
        RP  I837;
        RP  I843;
    } I476;
    RmaIbfPcode  I608;
} RmaICDelay;
typedef struct {
    U  I5;
    RP  I510;
    RmaEblk  I451;
    RmaIbfPcode  I608;
} RmaPortDelay;
typedef struct {
    RP  I548;
    RP  I616;
    RP  I448;
    U  I617 :30;
    U  I618 :1;
    U  I619 :1;
} RmaTcCoreSimple;
typedef struct {
    RP  I548;
    RP  I616;
    RP  I448;
    U  I617 :30;
    U  I618 :1;
    U  I619 :1;
    RP  I620;
} RmaTcCoreConditional;
typedef struct {
    RP  I616;
    RP  I448;
    U  I617 :30;
    U  I618 :1;
    U  I619 :1;
} RmaTcCoreSimpleNoList;
typedef struct {
    RP  I616;
    RP  I448;
    U  I617 :30;
    U  I618 :1;
    U  I619 :1;
    RP  I620;
} RmaTcCoreConditionalNoList;
typedef struct {
    RP  I621;
    U  I622;
    scalar  I623;
} RmaConditionalTSLoadNoList;
typedef struct {
    RP  I548;
    RP  I621;
    U  I622;
    scalar  I623;
} RmaConditionalTSLoad;
typedef struct {
    US  I624;
    scalar  val;
    RmaIbfPcode  I608;
} RmaScanSwitchData;
struct clock_load {
    U  I162 :5;
    U  I163 :12;
    U  I164 :1;
    U  I165 :2;
    U  I166 :1;
    U  I167 :1;
    U  I168 :1;
    U  I169 :9;
    U  I170;
    U  I171;
    void (* pfn)(void * I173, char val);
};
typedef struct clock_data {
    U  I178 :1;
    U  I179 :1;
    U  I180 :1;
    U  I181 :1;
    U  I162 :5;
    U  I163 :12;
    U  I182 :6;
    U  I183 :1;
    U  I165 :2;
    U  I166 :1;
    U  I169 :1;
    U  I184;
    U  I185;
    U  I186;
    U  I170;
    U  I187;
    U  I188;
    U  I189;
    U  I190;
    U  I191;
} HdbsClockData;
struct clock_hiconn {
    U  I195;
    U  I196;
    U  I170;
    U  I165;
};
typedef struct _RmaDaiCg {
    RP  I625;
    RP  I626;
    U  I627;
} RmaDaiCg;
struct futq {
    struct futq * I466;
    struct futq * I468;
    RmaEblk  * I469;
    RmaEblk  * I470;
    U  I462;
};
struct sched_table {
    struct futq * I471;
    struct futq I472;
    struct hash_bucket * I473;
};
struct dummyq_struct {
    clock_struct  I628;
    EBLK  * I629;
    EBLK  * I630;
    struct futq * I631;
    struct futq * I632;
    struct sched_table * I633;
    struct millenium * I635;
    EBLK  * I637;
    EBLK  * I638;
    EBLK  * I639;
    EBLK  * I640;
    EBLK  * I641;
    EBLK  * I642;
    EBLK  * I643;
    EBLK  * I644;
    EBLK  * I645;
    EBLK  * I646;
    EBLK  * I647;
    EBLK  * I648;
};
typedef void (* FP)(void *  , scalar   );
typedef void (* FP1)(void *  );
typedef U  (* FPU1)(void *  );
typedef void (* FPV)(void *  , UB  *  );
typedef void (* FPLSEL)(void *  , scalar   , U   );
typedef void (* FPLSELV)(void *  , vec32  *  , U   , U   );
typedef void (* FPFPV)(UB  *  , UB  *  , U   , U   , U   , U   , U   , UB  *  , U   );
typedef void (* FPRPV)(UB  *  , U   , U   , U   );
extern UB   Xvalchg[];
extern UB   X4val[];
extern UB   X3val[];
extern UB   XcvtstrTR[];
extern UB   Xbuf[];
extern UB   Xbitnot[];
extern UB   Xwor[];
extern UB   Xwand[];
extern U   Xbitnot4val[];
extern UB   globalTable1Input[];
extern unsigned long long vcs_clocks;
extern UB   Xunion[];
extern U  fRTFrcRelCbk;
extern FP  txpFnPtr;
extern FP   rmaFunctionArray[];
extern UB  dummyScalar;
extern UB  fScalarIsForced;
extern UB  fScalarIsReleased;
extern U  fNotimingchecks;
extern RP  * iparr;
extern FP1  * rmaPostAnySchedFnPtr;
extern FP1  * rmaPostAnySchedVFnPtr;
extern FP1  * rmaPostAnySchedWFnPtr;
extern FP1  * rmaPostAnySchedEFnPtr;
extern FP1  * rmaPostSchedUpdateClockStatusFnPtr;
extern FP1  * rmaPostSchedRecoveryResetDbsFnPtr;
extern U  fGblDataOrTime0Prop;
extern UB   rmaEdgeStatusValArr[];
extern FP1  * propForceCbkSPostSchedCgFnPtr;
extern FP1  * propForceCbkMemoptSPostSchedCgFnPtr;
extern UB  * ptableGbl;
typedef struct TableAssign_ {
    struct TableAssign_ * I548;
    struct TableAssign_ * I504;
    U  I5;
    RP  ptable;
    RP  I836;
} TableAssign;
typedef struct TableAssignList_ {
    U  I5;
    TableAssign  * I504;
    struct TableAssignList_ * I866;
    TableAssign   arr[1];
} TableAssignList;


extern void *mempcpy(void* s1, void* s2, unsigned n);
extern UB* rmaEvalDelays(UB* pcode, scalar val);
extern void rmaPopTransEvent(UB* pcode);
extern void rmaSetupFuncArray(UP* ra);
extern void SinitHsimPats(void);
extern void VVrpDaicb(void* ip, U nIndex);
extern int SDaicb(void *ip, U nIndex);
extern void SDaicbForHsimNoFlagScalar(void* pDaiCb, unsigned char value);
extern void SDaicbForHsimNoFlagStrengthScalar(void* pDaiCb, unsigned char value);
extern void SDaicbForHsimNoFlag(void* pRmaDaiCg, unsigned char value);
extern void SDaicbForHsimNoFlag2(void* pRmaDaiCg, unsigned char value);
extern void SDaicbForHsimWithFlag(void* pRmaDaiCg, unsigned char value);
extern void SDaicbForHsimNoFlagFrcRel(void* pRmaDaiCg, unsigned char reason, int msb, int lsb, int ndx);
extern void SDaicbForHsimNoFlagFrcRel2(void* pRmaDaiCg, unsigned char reason, int msb, int lsb, int ndx);
extern void VcsHsimValueChangeCB(void* pRmaDaiCg, void* pValue, unsigned int valueFormat);
extern U isNonDesignNodeCallbackList(void* pRmaDaiCg);
extern void SDaicbForHsimCbkMemOptNoFlagScalar(void* pDaiCb, unsigned char value, unsigned char isStrength);
extern void SDaicbForHsimCbkMemOptWithFlagScalar(void* pDaiCb, unsigned char value, unsigned char isStrength);
extern void SDaicbForHsimCbkMemOptNoFlagScalar(void* pDaiCb, unsigned char value, unsigned char isStrength);
extern void SDaicbForHsimCbkMemOptWithFlagScalar(void* pDaiCb, unsigned char value, unsigned char isStrength);
extern void VVrpNonEventNonRegdScalarForHsimOptCbkMemopt(void* ip, U nIndex);
extern void SDaicbForHsimCbkMemOptNoFlagDynElabScalar(U* mem, unsigned char value, unsigned char isStrength);
extern void SDaicbForHsimCbkMemOptWithFlagDynElabScalar(U* mem, unsigned char value, unsigned char isStrength);
extern void SDaicbForHsimCbkMemOptNoFlagDynElabFrcRel(U* mem, unsigned char reason, int msb, int lsb, int ndx);
extern void SDaicbForHsimCbkMemOptNoFlagFrcRel(void* pDaiCb, unsigned char reason, int msb, int lsb, int ndx);
extern void hsimDispatchCbkMemOptForVcd(RP p, U val);
extern void* hsimGetCbkMemOptCallback(RP p);
extern void hsimDispatchCbkMemOptNoDynElabS(RP p, U val, U isStrength);
extern void* hsimGetCbkPtrNoDynElab(RP p);
extern void hsimDispatchCbkMemOptDynElabS(U** pvcdarr, U** pcbkarr, U val, U isStrength);
extern void hsimDispatchCbkMemOptNoDynElabVector(RP /*RmaDaiOptCg* */p, void* pval, U /*RmaValueType*/ vt, U cbits);
extern void copyAndPropRootCbkCgS(RmaRootCbkCg* pRootCbk, scalar val);
extern void copyAndPropRootCbkCgV(RmaRootCbkCg* rootCbk, vec32* pval);
extern void copyAndPropRootCbkCgW(RmaRootCbkCg* rootCbk, vec32* pval);
extern void copyAndPropRootCbkCgE(RmaRootCbkCg* rootCbk, scalar* pval);
extern void dumpRootVcdCg(RmaRootVcdCg* pRootVcd, scalar val);
extern void Wsvvar_callback_virt_intf(RP* ptr);
extern void Wsvvar_callback_hsim_var(RP* ptr);
extern void checkAndConvertVec32To2State(vec32* value, vec32* svalue, U cbits, U* pforcedBits);
extern unsigned int fGblDataOrTime0Prop;
extern void SchedSemiLerMP1(UB* pmps, U partId);
extern void hsUpdateModpathTimeStamp(UB* pmps);
extern void doMpd32One(UB* pmps);
extern void SchedSemiLerMP(UB* ppulse, U partId);
extern void scheduleuna(UB *e, U t);
extern void scheduleuna_mp(EBLK *e, unsigned t);
extern void schedule(UB *e, U t);
extern void sched_hsopt(struct dummyq_struct * pQ, EBLK *e, U t);
extern void sched_millenium(struct dummyq_struct * pQ, void *e, U thigh, U t);
extern void schedule_1(EBLK *e);
extern void sched0(UB *e);
extern void sched0lq(UB *e);
extern void sched0una(UB *e);
extern void sched0una_th(struct dummyq_struct *pq, UB *e);
extern void scheduleuna_mp_th(struct dummyq_struct *pq, EBLK *e, unsigned t);
extern void schedal(UB *e);
extern void sched0_th(struct dummyq_struct * pQ, UB *e);
extern void sched0_hsim_front_th(struct dummyq_struct * pQ, UB *e);
extern void sched0_hsim_frontlq_th(struct dummyq_struct * pQ, UB *e);
extern void sched0lq_th(struct dummyq_struct * pQ, UB *e);
extern void schedal_th(struct dummyq_struct * pQ, UB *e);
extern void scheduleuna_th(struct dummyq_struct * pQ, UB *e, U t);
extern void schedule_th(struct dummyq_struct * pQ, UB *e, U t);
extern void schedule_1_th(struct dummyq_struct * pQ, EBLK *peblk);
extern void SetupLER_th(struct dummyq_struct * pQ, UB *e);
extern void SchedSemiLer_th(struct dummyq_struct * pQ, EBLK *e);
extern void SchedSemiLerTXP_th(struct dummyq_struct * pQ, EBLK *e);
extern void SchedSemiLerTXPFreeVar_th(struct dummyq_struct * pQ, EBLK *e);
extern U getVcdFlags(UB *ip);
extern void VVrpNonEventNonRegdScalarForHsimOpt(void* ip, U nIndex);
extern void VVrpNonEventNonRegdScalarForHsimOpt2(void* ip, U nIndex);
extern void SchedSemiLerTBReactiveRegion(struct eblk* peblk);
extern void SchedSemiLerTBReactiveRegion_th(struct eblk* peblk, U partId);
extern void SchedSemiLerTr(UB* peblk, U partId);
extern void appendNtcEvent(UB* phdr, scalar s, U schedDelta);
extern void hsimRegisterEdge(void* sm,  scalar s);
extern U pvcsGetPartId();
extern void HsimPVCSPartIdCheck(U instNo);
extern void debug_func(U partId, struct dummyq_struct* pQ, EBLK* EblkLastEventx); 
extern struct dummyq_struct* pvcsGetQ(U thid);
extern EBLK* pvcsGetLastEventEblk(U thid);
extern void insertTransEvent(RmaTransEventHdr* phdr, scalar s, scalar pv,	scalar resval, U schedDelta, int re, UB* predd, U fpdd);
extern void insertNtcEventRF(RmaTransEventHdr* phdr, scalar s, scalar pv, scalar resval, U schedDelta, U* delays);
extern U doTimingViolation(U ts,RP* pdata, U fskew, U limit, U floaded);
extern void sched_gate_hsim(EBLK* peblk, unsigned t, RP* offset);
extern int getCurSchedRegion();
extern FP getRoutPtr(RP, U);
extern U rmaChangeCheckAndUpdateE(scalar* pvalDst, scalar* pvalSrc, U cbits);
extern void rmaUpdateE(scalar* pvalDst, scalar* pvalSrc, U cbits);
extern U rmaChangeCheckAndUpdateEFromW(scalar* pvalDst, vec32* pvalSrc, U cbits);
extern void rmaLhsPartSelUpdateE(scalar* pvalDst, scalar* pvalSrc, U index, U width);
extern void rmaUpdateWithForceSelectorE(scalar* pvalDst, scalar* pvalSrc, U cbits, U* pforceSelector);
extern void rmaUpdateWFromE(vec32* pvalDst, scalar* pvalSrc, U cbits);
extern U rmaLhsPartSelWithChangeCheckE(scalar* pvalDst, scalar* pvalSrc, U index, U width);
extern void rmaLhsPartSelWFromE(vec32* pvalDst, scalar* pvalSrc, U index,U width);
extern U rmaChangeCheckAndUpdateW(vec32* pvalDst, vec32* pvalSrc, U cbits);
extern void rmaUpdateW(vec32* pvalDst, vec32* pvalSrc, U cbits);
extern void rmaUpdateEFromW(scalar* pvalDst, vec32* pvalSrc, U cbits);
extern U rmaLhsPartSelWithChangeCheckW(vec32* pvalDst, vec32* pvalSrc, U index,U width);
extern void rmaLhsPartSelEFromW(scalar* pvalDst, vec32* pvalSrc, U index,U width);
extern void rmaLhsPartSelWithChangeCheckEFromW(scalar* pvalDst, vec32* pvalSrc, U index,U width);
extern void rmaLhsPartSelUpdateW(vec32* pvalDst, vec32* pvalSrc, U index, U width);
extern void rmaEvalWunionW(vec32* dst, vec32* src, U cbits, U count);
extern void rmaEvalWorW(vec32* dst, vec32* src, U cbits, U count);
extern void rmaEvalWandW(vec32* dst, vec32* src, U cbits, U count);
extern void rmaEvalUnionE(scalar* dst, scalar* src, U cbits, U count, RP ptable);
typedef U RmaCgFunctionType;
extern RmaIbfPcode* rmaEvalPartSelectsW(vec32* pvec32, U startIndex, U onWidth, U offWidth, U count, RmaIbfPcode* pibfPcode, U fnonRootForce);
extern RmaIbfPcode* rmaEvalPartSelectsEToE(scalar* pv, U startIndex, U onWidth, U offWidth, U count, RmaIbfPcode* pibfPcode, U fnonRootForce);
extern RmaIbfPcode* rmaEvalPartSelectsEToW(scalar* pv, U startIndex, U onWidth, U offWidth, U count, RmaIbfPcode* pibfPcode, U fnonRootForce);
extern U rmaEvalBitPosEdgeW(vec32* pvalCurr, vec32* pvalPrev, U cbits, U* pedges);
extern U rmaEvalBitNegEdgeW(vec32* pvalCurr, vec32* pvalPrev, U cbits, U* pedges);
extern U rmaEvalBitChangeW(vec32* pvalCurr, vec32* pvalPrev, U cbits, U* pedges);
extern U rmaEvalBitPosEdgeW(vec32* pvalCurr, vec32* pvalPrev, U cbits, U* pedges);
extern U rmaEvalBitNegEdgeW(vec32* pvalCurr, vec32* pvalPrev, U cbits, U* pedges);
extern U rmaEvalBitChangeW(vec32* pvalCurr, vec32* pvalPrev, U cbits, U* pedges);
extern U VcsForceVecVCg(UB* pcode, UB* pval, UB* pvDst, UB* pvCur, U fullcbits, U ibeginSrc, U ibeginDst, U width, U/*RmaValueConvType*/ convtype, U/*RmaForceType*/ frcType, UB* prhs, UB* prhsDst, U frhs, U* pforcedbits, U fisRoot);
extern U VcsReleaseVecVCg(UB* pcode, UB* pvDst, U fullcbits, U ibeginDst, U width, UB* prhsDst, U frhs, U* pforcedbits, U fisRoot);
extern U VcsForceVecWCg(UB* pcode, UB* pval, UB* pvDst, UB* pvCur, U fullcbits, U ibeginSrc, U ibeginDst, U width, U/*RmaValueConvType*/ convtype, U /*RmaForceType*/ frcType, UB* prhs, UB* prhsDst, U frhs, U* pforcedbits, U fisRoot);
extern U VcsReleaseVecWCg(UB* pcode, UB* pvDst, U fullcbits, U ibeginDst, U width, UB* prhsDst, U frhs, U* pforcedbits, U fisRoot);
extern U VcsForceVecECg(UB* pcode, UB* pval, UB* pvDst, UB* pvCur, U fullcbits, U ibeginSrc, U ibeginDst, U width, U /*RmaValueConvType*/ convtype, U /*RmaForceType*/ frcType,UB* prhs, UB* prhsDst, U frhs, U* pforcedbits, U fisRoot);
extern U VcsReleaseVecCg(UB* pcode, UB* pvDst, U ibeginDst, U width, U /*RmaValueType*/ type,U fisRoot, UB* prhsDst, U frhs, U* pforcedbits);
extern U VcsDriveBitsAndDoChangeCheckV(vec32* pvSel, vec32* pvCur, U fullcbits, U* pforcedbits, U isRoot);
extern U VcsDriveBitsAndDoChangeCheckW(vec32* pvSel, vec32* pvCur, U fullcbits, U* pforcedbits, U isRoot);
extern U VcsDriveBitsAndDoChangeCheckE(scalar* pvSel, scalar* pvCur, U fullcbits, U* pforcedbits, U isRoot);
extern void cgvecDebug_Eblk(UB* pcode);
extern U rmaCmpW(vec32* pvalDst, vec32* pvalSrc, U index, U width);
extern void copyVec32ArrMask(vec32* pv1, vec32* pv2, U len, U* mask);
extern void* memcpy(void*, void*, U);
extern int memcmp(void*, void*, U);
extern UB* rmaProcessScanSwitches(UB* pcode, scalar val);
extern UB* rmaProcessScanChainOptSeqPrims(UB* pcode, scalar val);
extern void schedResetRecoveryDbs(U cedges, EBLK* peblkFirst);


#ifdef __cplusplus
extern "C" {
#endif
void  hsF0_0_0_(UB  * I597, scalar  val);
void  hsF0_0_1_(UB  * I597, scalar  val, U  I665, scalar  * I664);
void  hsF0_0_2_(UB  * I597);
void  hsF0_0_5_(UB  * I597, UB  val);
void  hsF0_1_0_(UB  * I597, scalar  val);
void  hsF0_1_1_(UB  * I597, scalar  val, U  I665, scalar  * I664);
void  hsF0_1_2_(UB  * I597);
void  hsF0_4_0_(UB  * I597, scalar  val);
void  hsF0_4_1_(UB  * I597, scalar  val, U  I665, scalar  * I664);
void  hsF0_4_2_(UB  * I597);
void  hsF0_4_5_(UB  * I597, UB  val);
void  schedNewEvent(struct dummyq_struct * I651, EBLK  * I652, U  I509);
#ifdef __cplusplus
}
#endif

#ifdef __cplusplus
  }
#endif
#endif /*__DO_RMAHDR_*/

