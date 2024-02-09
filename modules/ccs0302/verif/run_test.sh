#!/bin/sh

function usage()
{
    echo "Script to run testcases for $PROJECT_NAME"
    echo "./run_test.sh --test <test name in $PROJECT_MODULES/ccs0302/verif/testcases directory>"
    echo "\t-h --help"
    echo "\t--test=test name in $PROJECT_MODULES/ccs0302/verif/testcases directory"
    echo ""
}

    #GUI=  `echo $3 | awk -F= '{print $1}'`
while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $2 | awk -F= '{print $1}'`

    case $PARAM in
        -h | --help)
            usage
            exit
            ;;
        -test | --test)
            TEST_CASE=$VALUE
            ;;
        -gui | --gui)
            GUI=$VALUE
            ;;
        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;
    esac
    shift
    shift
done


if [ $TEST_CASE == "ntt.v" ]
then
  echo "---------------------Running Python Code ntt.py---------------------"
  python3.8 ntt.py > python_ntt.log
elif [ $TEST_CASE == "ntt_dp.v" ]
then
  echo "---------------------Running Python Code ntt_dp.v---------------------"
  python3.8 ntt_dp.py > python_ntt_dp.log
elif [ $TEST_CASE == "ntt_cf_dp.v" ]
then
  echo "---------------------Running Python Code ntt_cf_dp.py---------------------"
  python3.8 ntt_cf_dp.py > python_ntt_cf_dp.log
elif [ $TEST_CASE == "ntt_regress.v" ]
then
  echo "---------------------Running Python Code ntt_regress.py---------------------"
  python3.8 ntt_regress.py > python_ntt_regress.log
elif [ $TEST_CASE == "ntt_regress_cf_dp.v" ]
then
  echo "---------------------Running Python Code ntt_regress_cf_dp.py---------------------"
  python3.8 ntt_regress_cf_dp.py > python_ntt_regress_cf_dp.log
elif [ $TEST_CASE == "mul.v" ]
then
  echo "---------------------Running Python Code mul.py---------------------"
  python3.8 mul.py > python_mul.log
elif [ $TEST_CASE == "constmul.v" ]
then
  echo "---------------------Running Python Code constmul.py---------------------"
  python3.8 constmul.py > python_constmul.log
elif [ $TEST_CASE == "add.v" ]
then
  echo "---------------------Running Python Code add.py---------------------"
  python3.8 add.py > python_add.log
elif [ $TEST_CASE == "sub.v" ]
then
  echo "---------------------Running Python Code sub.py---------------------"
  python3.8 sub.py > python_sub.log
elif [ $TEST_CASE == "intt.v" ]
then
  echo "---------------------Running Python Code intt.py---------------------"
  python3.8 intt.py > python_intt.log
elif [ $TEST_CASE == "ntt_regress_cf.v" ]
then
  echo "---------------------Running Python Code ntt_regress_cf.py---------------------"
  python3.8  ntt_regress_cf.py > python_ntt_regress_cf.log
elif [ $TEST_CASE == "intt_cf.v" ]
then
  echo "---------------------Running Python Code intt_cf.py---------------------"
  python3.8  intt_cf.py > python_intt_cf.log
elif [ $TEST_CASE == "polymul_cf.v" ]
then
  echo "---------------------Running Python Code polymul_cf.py---------------------"
  python3.8  polymul_cf.py > python_polymul_cf.log
elif [ $TEST_CASE == "polymul_cf_dp.v" ]
then
  echo "---------------------Running Python Code polymul_cf_dp.py---------------------"
  python3.8  polymul_cf_dp.py > python_polymul_cf_dp.log
else
  echo "---------------------Cannot find Python script for this testcase-----------------"
fi
#
#grep PASSED python*.log
#grep FAILED python*.log
 echo "Done Running Python Code"

if [ ! -f $PROJECT_MODULES/ccs0302/verif/testcases/$TEST_CASE ]
then
echo "---------------------Cannot find \"$TEST_CASE\" in \"$PROJECT_MODULES/ccs0302/verif/testcases\"-----------------"
exit 1
fi

echo "---------------------Running \"$TEST_CASE\" in \"$PROJECT_MODULES/ccs0302/verif/testcases\"-----------------"

if [ -L $PROJECT_MODULES/ccs0302/verif/hex/test.hex ]
then
 rm $PROJECT_MODULES/ccs0302/verif/hex/test.hex
fi
 ln -s $PROJECT_MODULES/ccs0302/verif/testcases/$TEST_CASE $PROJECT_MODULES/ccs0302/verif/hex/test.hex

if [ -f inter.vpd ]
then
rm -rf inter.vpd simv session.inter.vpd.tcl simv.log  vlogan.log vcs.log csrc ucli.key DVEfiles simv.daidir $PROJECT_PATH/verif/work/AN.DB
fi

echo "---------------------Running vlogan-----------------"

vlogan -kdb -sverilog  /home/projects/vlsi/libraries/55lpe/ref_lib/arm/std_cells/hvt/verilog/sc9_55lpe_base_hvt.v \
                  /home/projects/vlsi/libraries/55lpe/ref_lib/arm/std_cells/hvt/verilog/sc9_55lpe_base_hvt_udp.v \
                 ./ccs0302_tb.v ./pad_model.v ./padring_tb.v ./SPI_Master.v \
                  $PROJECT_MODULES/ccs0302/rtl/ccs0302_define.v \
                  $PROJECT_MODULES/cortexm0/rtl/cortexm0ds_logic_128_all.v \
                  $PROJECT_MODULES/cortexm0/rtl/CORTEXM0DS.v \
                  $PROJECT_MODULES/chip_core/rtl/CORTEXM0DS_wrap.v \
                  $PROJECT_MODULES/memss/rtl/pram.v \
                  $PROJECT_MODULES/memss/rtl/sram_wrap.v \
                  $PROJECT_MODULES/memss/rtl/sram_wrap_cm0.v \
                  $PROJECT_MODULES/memss/rtl/sram_wrap_dp.v \
                  $PROJECT_MODULES/dma/rtl/dma.v \
                  $PROJECT_MODULES/mdmc/rtl/mdmc.v \
                  $PROJECT_MODULES/mdmc/rtl/mdmc_ahb.v \
                  $PROJECT_MODULES/multpool/rtl/multpool_rd_wr.v \
                  $PROJECT_MODULES/multpool/rtl/mutlpool_rdata_mux.v \
                  $PROJECT_MODULES/multpool/rtl/mod_mul_il.v \
                  $PROJECT_MODULES/multpool/rtl/mod_mul.v \
                  $PROJECT_MODULES/multpool/rtl/nom_mul.v \
                  $PROJECT_MODULES/multpool/rtl/barrett_red.v \
                  $PROJECT_MODULES/multpool/rtl/butterfly.v \
                  $PROJECT_MODULES/multpool/rtl/mul_fifo.v \
                  $PROJECT_MODULES/multpool/rtl/multpool.v \
                  $PROJECT_MODULES/ahb_ic/rtl/ahb_ic.v \
                  $PROJECT_MODULES/uartm/rtl/uartm.v \
                  $PROJECT_MODULES/uartm/rtl/uartm_rx.v \
                  $PROJECT_MODULES/uartm/rtl/uartm_tx.v \
                  $PROJECT_MODULES/uartm/rtl/uartm_ahb.v \
                  $PROJECT_MODULES/spim/rtl/spim.v \
                  $PROJECT_MODULES/spim/rtl/spim_ahb.v \
                  $PROJECT_MODULES/spim/rtl/SPI_Slave.v \
                  $PROJECT_MODULES/gpcfg/rtl/gpcfg_rd.v \
                  $PROJECT_MODULES/gpcfg/rtl/gpcfg_rd_wr.v \
                  $PROJECT_MODULES/gpcfg/rtl/gpcfg_rd_wr_p.v \
                  $PROJECT_MODULES/gpcfg/rtl/gpcfg.v \
                  $PROJECT_MODULES/gpcfg/rtl/command_fifo.v \
                  $PROJECT_MODULES/gpcfg/rtl/gpcfg_rdata_mux.v \
                  $PROJECT_MODULES/gpio/rtl/gpio.v \
                  $PROJECT_MODULES/timer/rtl/timer.v \
                  $PROJECT_MODULES/uarts/rtl/uarts_rx.v \
                  $PROJECT_MODULES/uarts/rtl/uarts_tx.v \
                  $PROJECT_MODULES/uarts/rtl/uarts.v \
                  $PROJECT_MODULES/chip_core/rtl/chip_core.v \
                  $PROJECT_MODULES/chip_core/rtl/ro_gen.v \
                  $PROJECT_MODULES/clk_ctl/rtl/clkdiv.v \
                  $PROJECT_MODULES/clk_ctl/rtl/clk_rst_ctl.v \
                  $PROJECT_MODULES/clk_ctl/rtl/AD_PLL.v \
                  $PROJECT_MODULES/clk_ctl/rtl/gfm.v \
                  $PROJECT_MODULES/ccs0302/rtl/ccs0302.v \
                  $PROJECT_MODULES/padring/rtl/padring.v \
                  $PROJECT_MODULES/chiplib/rtl/chiplib.v \
                  $PROJECT_MODULES/padring/rtl/rgo_csm65_25v33_50.v \
                  $PROJECT_MODULES/memss/rtl/sram_dp_16x4096.v \
                  $PROJECT_MODULES/memss/rtl/spram_hd_32x4096.v \
                  $PROJECT_MODULES/memss/rtl/spram_hd_32x8192.v \
                  $PROJECT_MODULES/memss/rtl/sram_hs_32x8192.v \
                  +incdir+/home/projects/vlsi/ccs0302/design/modules/multpool/rtl \
                  +incdir+/home/projects/vlsi/ccs0302/design/modules/uartm/rtl \
                  +incdir+/home/projects/vlsi/ccs0302/design/modules/spim/rtl \
                  +incdir+/home/projects/vlsi/ccs0302/design/modules/uarts/rtl \
                  +incdir+/home/projects/vlsi/ccs0302/design/modules/gpcfg/rtl | tee vlogan.log

echo "---------------------vlogan Done--------------------"
echo "---------------------Running VCS--------------------"
vcs -kdb  +vcs+lic+wait +lint=TFIPC-L  -debug ccs0302_tb | tee vcs.log

echo "---------------------VCS    Done--------------------"

if [ $GUI ]
then
./simv -l simv.log -gui=sx -i ./runtime.tcl &
exit 1
else 
./simv -l simv.log
exit 1
fi

#./simv
