#!/bin/sh

function usage()
{
    echo "Script to run testcases for $PROJECT_NAME"
    echo "./run_test.sh --test <test name in $PROJECT_MODULES/ccs0201/verif/testcases directory>"
    echo "\t-h --help"
    echo "\t--test=test name in $PROJECT_MODULES/ccs0201/verif/testcases directory"
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

if [ ! -f $PROJECT_MODULES/ccs0201/verif/testcases/$TEST_CASE ]
then
echo "---------------------Cannot find \"$TEST_CASE\" in \"$PROJECT_MODULES/ccs0201/verif/testcases\"-----------------"
exit 1
fi

echo "---------------------Running \"$TEST_CASE\" in \"$PROJECT_MODULES/ccs0201/verif/testcases\"-----------------"

if [ -L $PROJECT_MODULES/ccs0201/verif/hex/test_gls.hex ]
then
 rm $PROJECT_MODULES/ccs0201/verif/hex/test_gls.hex
fi
 ln -s $PROJECT_MODULES/ccs0201/verif/testcases/$TEST_CASE $PROJECT_MODULES/ccs0201/verif/hex/test_gls.hex
###echo "---------------------Running hexdump-----------------"
####hexdump  -e  '/4 "%08_ax "' -e '/4 "%08X" "\n"'  $PROJECT_MODULES/$PROJECT_NAME/sw/$TEST_CASE/Debug/Exe/project.bin   | grep -v "*" | awk  '{print "uartm_write","\(" ".addr\(32'\h" $1 "\)\,", ".data\(32\'h" $2 "\)\);"}' > $PROJECT_MODULES/$PROJECT_NAME/verif/test_$TEST_CASE/test.hex
###unzip -o $PROJECT_MODULES/$PROJECT_NAME/sw/$TEST_CASE/Debug/Exe/project.zip -d  $PROJECT_MODULES/$PROJECT_NAME/sw/$TEST_CASE/Debug/Exe/
###hexdump -n 200                 -v -e  '/4 "%08_ax "' -e '/4 "%08X" "\n"'  $PROJECT_MODULES/$PROJECT_NAME/sw/$TEST_CASE/Debug/Exe/project.bin >  $PROJECT_MODULES/$PROJECT_NAME/verif/test_$TEST_CASE/test.txt
###hexdump -n 32768 -s 536870912  -v -e  '/4 "%08_ax "' -e '/4 "%08X" "\n"'  $PROJECT_MODULES/$PROJECT_NAME/sw/$TEST_CASE/Debug/Exe/project.bin >> $PROJECT_MODULES/$PROJECT_NAME/verif/test_$TEST_CASE/test.txt
###$PROJECT_MODULES/$PROJECT_NAME/verif/hexdump.py  $PROJECT_MODULES/$PROJECT_NAME/verif/test_$TEST_CASE/test.txt $PROJECT_MODULES/$PROJECT_NAME/verif/test_$TEST_CASE/test.hex
###
###
###
###
####cp     $PROJECT_MODULES/$PROJECT_NAME/verif/hex/$HEX_FILE           $PROJECT_MODULES/$PROJECT_NAME/verif/test_$TEST_CASE/test.hex
###ln -s  $PROJECT_MODULES/$PROJECT_NAME/verif/test_$TEST_CASE/test.hex  $PROJECT_MODULES/$PROJECT_NAME/verif/hex/test.hex

if [ -f inter.vpd ]
then
rm -rf inter.vpd simv session.inter.vpd.tcl simv.log  vlogan.log vcs.log csrc ucli.key DVEfiles simv.daidir
fi

echo "---------------------Running vlogan-----------------"

vlogan -sverilog  /home/projects/vlsi/libraries/55lpe/ref_lib/arm/std_cells/hvt/verilog/sc9_55lpe_base_hvt.v $PROJECT_MODULES/padring/rtl/rgo_csm65_25v33_50.v /home/projects/vlsi/libraries/55lpe/55lpe/sram/sram_sp_hde.v  ./pad_model.v ./padring_tb.v /home/projects/vlsi/ccs0201/design/modules/ccs0201/synth/24_Sep_2019/netlist/ccs0201.v ccs0201_tb_gls.v  +delay_mode_zero  | tee vlogan.log

echo "---------------------vlogan Done--------------------"
echo "---------------------Running VCS--------------------"
vcs -debug ccs0201_tb -sverilog -o simv_gls | tee vcs_gls.log

echo "---------------------VCS    Done--------------------"

if [ $GUI ]
then
./simv_gls -l simv_gls.log -gui -i ./runtime.tcl &
exit 1
fi

./simv_gls -l simv_gls.log
#./simv
