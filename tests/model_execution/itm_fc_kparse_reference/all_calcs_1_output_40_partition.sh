#!/bin/bash
SCRIPT=$(readlink -f "$0") && cd $(dirname "$SCRIPT")

# --- Script Init ---
set -euET -o pipefail
shopt -s inherit_errexit 2>/dev/null || echo "WARNING: Unable to set inherit_errexit. Possibly unsupported by this shell, Subprocess failures may not be detected."

mkdir -p log
rm -R -f log/*

# --- Setup run dirs ---

find output -type f -not -name '*summary-info*' -not -name '*.json' -exec rm -R -f {} +
mkdir output/full_correlation/

rm -R -f fifo/*
mkdir fifo/full_correlation/
rm -R -f work/*
mkdir work/kat/
mkdir work/full_correlation/
mkdir work/full_correlation/kat/

mkdir work/gul_S1_summaryleccalc
mkdir work/gul_S1_summaryaalcalc
mkdir work/full_correlation/gul_S1_summaryleccalc
mkdir work/full_correlation/gul_S1_summaryaalcalc
mkdir work/il_S1_summaryleccalc
mkdir work/il_S1_summaryaalcalc
mkdir work/full_correlation/il_S1_summaryleccalc
mkdir work/full_correlation/il_S1_summaryaalcalc

mkfifo fifo/full_correlation/gul_fc_P1
mkfifo fifo/full_correlation/gul_fc_P2
mkfifo fifo/full_correlation/gul_fc_P3
mkfifo fifo/full_correlation/gul_fc_P4
mkfifo fifo/full_correlation/gul_fc_P5
mkfifo fifo/full_correlation/gul_fc_P6
mkfifo fifo/full_correlation/gul_fc_P7
mkfifo fifo/full_correlation/gul_fc_P8
mkfifo fifo/full_correlation/gul_fc_P9
mkfifo fifo/full_correlation/gul_fc_P10
mkfifo fifo/full_correlation/gul_fc_P11
mkfifo fifo/full_correlation/gul_fc_P12
mkfifo fifo/full_correlation/gul_fc_P13
mkfifo fifo/full_correlation/gul_fc_P14
mkfifo fifo/full_correlation/gul_fc_P15
mkfifo fifo/full_correlation/gul_fc_P16
mkfifo fifo/full_correlation/gul_fc_P17
mkfifo fifo/full_correlation/gul_fc_P18
mkfifo fifo/full_correlation/gul_fc_P19
mkfifo fifo/full_correlation/gul_fc_P20
mkfifo fifo/full_correlation/gul_fc_P21
mkfifo fifo/full_correlation/gul_fc_P22
mkfifo fifo/full_correlation/gul_fc_P23
mkfifo fifo/full_correlation/gul_fc_P24
mkfifo fifo/full_correlation/gul_fc_P25
mkfifo fifo/full_correlation/gul_fc_P26
mkfifo fifo/full_correlation/gul_fc_P27
mkfifo fifo/full_correlation/gul_fc_P28
mkfifo fifo/full_correlation/gul_fc_P29
mkfifo fifo/full_correlation/gul_fc_P30
mkfifo fifo/full_correlation/gul_fc_P31
mkfifo fifo/full_correlation/gul_fc_P32
mkfifo fifo/full_correlation/gul_fc_P33
mkfifo fifo/full_correlation/gul_fc_P34
mkfifo fifo/full_correlation/gul_fc_P35
mkfifo fifo/full_correlation/gul_fc_P36
mkfifo fifo/full_correlation/gul_fc_P37
mkfifo fifo/full_correlation/gul_fc_P38
mkfifo fifo/full_correlation/gul_fc_P39
mkfifo fifo/full_correlation/gul_fc_P40

mkfifo fifo/gul_P1
mkfifo fifo/gul_P2
mkfifo fifo/gul_P3
mkfifo fifo/gul_P4
mkfifo fifo/gul_P5
mkfifo fifo/gul_P6
mkfifo fifo/gul_P7
mkfifo fifo/gul_P8
mkfifo fifo/gul_P9
mkfifo fifo/gul_P10
mkfifo fifo/gul_P11
mkfifo fifo/gul_P12
mkfifo fifo/gul_P13
mkfifo fifo/gul_P14
mkfifo fifo/gul_P15
mkfifo fifo/gul_P16
mkfifo fifo/gul_P17
mkfifo fifo/gul_P18
mkfifo fifo/gul_P19
mkfifo fifo/gul_P20
mkfifo fifo/gul_P21
mkfifo fifo/gul_P22
mkfifo fifo/gul_P23
mkfifo fifo/gul_P24
mkfifo fifo/gul_P25
mkfifo fifo/gul_P26
mkfifo fifo/gul_P27
mkfifo fifo/gul_P28
mkfifo fifo/gul_P29
mkfifo fifo/gul_P30
mkfifo fifo/gul_P31
mkfifo fifo/gul_P32
mkfifo fifo/gul_P33
mkfifo fifo/gul_P34
mkfifo fifo/gul_P35
mkfifo fifo/gul_P36
mkfifo fifo/gul_P37
mkfifo fifo/gul_P38
mkfifo fifo/gul_P39
mkfifo fifo/gul_P40

mkfifo fifo/gul_S1_summary_P1
mkfifo fifo/gul_S1_summary_P1.idx
mkfifo fifo/gul_S1_eltcalc_P1
mkfifo fifo/gul_S1_summarycalc_P1
mkfifo fifo/gul_S1_pltcalc_P1

mkfifo fifo/gul_S1_summary_P2
mkfifo fifo/gul_S1_summary_P2.idx
mkfifo fifo/gul_S1_eltcalc_P2
mkfifo fifo/gul_S1_summarycalc_P2
mkfifo fifo/gul_S1_pltcalc_P2

mkfifo fifo/gul_S1_summary_P3
mkfifo fifo/gul_S1_summary_P3.idx
mkfifo fifo/gul_S1_eltcalc_P3
mkfifo fifo/gul_S1_summarycalc_P3
mkfifo fifo/gul_S1_pltcalc_P3

mkfifo fifo/gul_S1_summary_P4
mkfifo fifo/gul_S1_summary_P4.idx
mkfifo fifo/gul_S1_eltcalc_P4
mkfifo fifo/gul_S1_summarycalc_P4
mkfifo fifo/gul_S1_pltcalc_P4

mkfifo fifo/gul_S1_summary_P5
mkfifo fifo/gul_S1_summary_P5.idx
mkfifo fifo/gul_S1_eltcalc_P5
mkfifo fifo/gul_S1_summarycalc_P5
mkfifo fifo/gul_S1_pltcalc_P5

mkfifo fifo/gul_S1_summary_P6
mkfifo fifo/gul_S1_summary_P6.idx
mkfifo fifo/gul_S1_eltcalc_P6
mkfifo fifo/gul_S1_summarycalc_P6
mkfifo fifo/gul_S1_pltcalc_P6

mkfifo fifo/gul_S1_summary_P7
mkfifo fifo/gul_S1_summary_P7.idx
mkfifo fifo/gul_S1_eltcalc_P7
mkfifo fifo/gul_S1_summarycalc_P7
mkfifo fifo/gul_S1_pltcalc_P7

mkfifo fifo/gul_S1_summary_P8
mkfifo fifo/gul_S1_summary_P8.idx
mkfifo fifo/gul_S1_eltcalc_P8
mkfifo fifo/gul_S1_summarycalc_P8
mkfifo fifo/gul_S1_pltcalc_P8

mkfifo fifo/gul_S1_summary_P9
mkfifo fifo/gul_S1_summary_P9.idx
mkfifo fifo/gul_S1_eltcalc_P9
mkfifo fifo/gul_S1_summarycalc_P9
mkfifo fifo/gul_S1_pltcalc_P9

mkfifo fifo/gul_S1_summary_P10
mkfifo fifo/gul_S1_summary_P10.idx
mkfifo fifo/gul_S1_eltcalc_P10
mkfifo fifo/gul_S1_summarycalc_P10
mkfifo fifo/gul_S1_pltcalc_P10

mkfifo fifo/gul_S1_summary_P11
mkfifo fifo/gul_S1_summary_P11.idx
mkfifo fifo/gul_S1_eltcalc_P11
mkfifo fifo/gul_S1_summarycalc_P11
mkfifo fifo/gul_S1_pltcalc_P11

mkfifo fifo/gul_S1_summary_P12
mkfifo fifo/gul_S1_summary_P12.idx
mkfifo fifo/gul_S1_eltcalc_P12
mkfifo fifo/gul_S1_summarycalc_P12
mkfifo fifo/gul_S1_pltcalc_P12

mkfifo fifo/gul_S1_summary_P13
mkfifo fifo/gul_S1_summary_P13.idx
mkfifo fifo/gul_S1_eltcalc_P13
mkfifo fifo/gul_S1_summarycalc_P13
mkfifo fifo/gul_S1_pltcalc_P13

mkfifo fifo/gul_S1_summary_P14
mkfifo fifo/gul_S1_summary_P14.idx
mkfifo fifo/gul_S1_eltcalc_P14
mkfifo fifo/gul_S1_summarycalc_P14
mkfifo fifo/gul_S1_pltcalc_P14

mkfifo fifo/gul_S1_summary_P15
mkfifo fifo/gul_S1_summary_P15.idx
mkfifo fifo/gul_S1_eltcalc_P15
mkfifo fifo/gul_S1_summarycalc_P15
mkfifo fifo/gul_S1_pltcalc_P15

mkfifo fifo/gul_S1_summary_P16
mkfifo fifo/gul_S1_summary_P16.idx
mkfifo fifo/gul_S1_eltcalc_P16
mkfifo fifo/gul_S1_summarycalc_P16
mkfifo fifo/gul_S1_pltcalc_P16

mkfifo fifo/gul_S1_summary_P17
mkfifo fifo/gul_S1_summary_P17.idx
mkfifo fifo/gul_S1_eltcalc_P17
mkfifo fifo/gul_S1_summarycalc_P17
mkfifo fifo/gul_S1_pltcalc_P17

mkfifo fifo/gul_S1_summary_P18
mkfifo fifo/gul_S1_summary_P18.idx
mkfifo fifo/gul_S1_eltcalc_P18
mkfifo fifo/gul_S1_summarycalc_P18
mkfifo fifo/gul_S1_pltcalc_P18

mkfifo fifo/gul_S1_summary_P19
mkfifo fifo/gul_S1_summary_P19.idx
mkfifo fifo/gul_S1_eltcalc_P19
mkfifo fifo/gul_S1_summarycalc_P19
mkfifo fifo/gul_S1_pltcalc_P19

mkfifo fifo/gul_S1_summary_P20
mkfifo fifo/gul_S1_summary_P20.idx
mkfifo fifo/gul_S1_eltcalc_P20
mkfifo fifo/gul_S1_summarycalc_P20
mkfifo fifo/gul_S1_pltcalc_P20

mkfifo fifo/gul_S1_summary_P21
mkfifo fifo/gul_S1_summary_P21.idx
mkfifo fifo/gul_S1_eltcalc_P21
mkfifo fifo/gul_S1_summarycalc_P21
mkfifo fifo/gul_S1_pltcalc_P21

mkfifo fifo/gul_S1_summary_P22
mkfifo fifo/gul_S1_summary_P22.idx
mkfifo fifo/gul_S1_eltcalc_P22
mkfifo fifo/gul_S1_summarycalc_P22
mkfifo fifo/gul_S1_pltcalc_P22

mkfifo fifo/gul_S1_summary_P23
mkfifo fifo/gul_S1_summary_P23.idx
mkfifo fifo/gul_S1_eltcalc_P23
mkfifo fifo/gul_S1_summarycalc_P23
mkfifo fifo/gul_S1_pltcalc_P23

mkfifo fifo/gul_S1_summary_P24
mkfifo fifo/gul_S1_summary_P24.idx
mkfifo fifo/gul_S1_eltcalc_P24
mkfifo fifo/gul_S1_summarycalc_P24
mkfifo fifo/gul_S1_pltcalc_P24

mkfifo fifo/gul_S1_summary_P25
mkfifo fifo/gul_S1_summary_P25.idx
mkfifo fifo/gul_S1_eltcalc_P25
mkfifo fifo/gul_S1_summarycalc_P25
mkfifo fifo/gul_S1_pltcalc_P25

mkfifo fifo/gul_S1_summary_P26
mkfifo fifo/gul_S1_summary_P26.idx
mkfifo fifo/gul_S1_eltcalc_P26
mkfifo fifo/gul_S1_summarycalc_P26
mkfifo fifo/gul_S1_pltcalc_P26

mkfifo fifo/gul_S1_summary_P27
mkfifo fifo/gul_S1_summary_P27.idx
mkfifo fifo/gul_S1_eltcalc_P27
mkfifo fifo/gul_S1_summarycalc_P27
mkfifo fifo/gul_S1_pltcalc_P27

mkfifo fifo/gul_S1_summary_P28
mkfifo fifo/gul_S1_summary_P28.idx
mkfifo fifo/gul_S1_eltcalc_P28
mkfifo fifo/gul_S1_summarycalc_P28
mkfifo fifo/gul_S1_pltcalc_P28

mkfifo fifo/gul_S1_summary_P29
mkfifo fifo/gul_S1_summary_P29.idx
mkfifo fifo/gul_S1_eltcalc_P29
mkfifo fifo/gul_S1_summarycalc_P29
mkfifo fifo/gul_S1_pltcalc_P29

mkfifo fifo/gul_S1_summary_P30
mkfifo fifo/gul_S1_summary_P30.idx
mkfifo fifo/gul_S1_eltcalc_P30
mkfifo fifo/gul_S1_summarycalc_P30
mkfifo fifo/gul_S1_pltcalc_P30

mkfifo fifo/gul_S1_summary_P31
mkfifo fifo/gul_S1_summary_P31.idx
mkfifo fifo/gul_S1_eltcalc_P31
mkfifo fifo/gul_S1_summarycalc_P31
mkfifo fifo/gul_S1_pltcalc_P31

mkfifo fifo/gul_S1_summary_P32
mkfifo fifo/gul_S1_summary_P32.idx
mkfifo fifo/gul_S1_eltcalc_P32
mkfifo fifo/gul_S1_summarycalc_P32
mkfifo fifo/gul_S1_pltcalc_P32

mkfifo fifo/gul_S1_summary_P33
mkfifo fifo/gul_S1_summary_P33.idx
mkfifo fifo/gul_S1_eltcalc_P33
mkfifo fifo/gul_S1_summarycalc_P33
mkfifo fifo/gul_S1_pltcalc_P33

mkfifo fifo/gul_S1_summary_P34
mkfifo fifo/gul_S1_summary_P34.idx
mkfifo fifo/gul_S1_eltcalc_P34
mkfifo fifo/gul_S1_summarycalc_P34
mkfifo fifo/gul_S1_pltcalc_P34

mkfifo fifo/gul_S1_summary_P35
mkfifo fifo/gul_S1_summary_P35.idx
mkfifo fifo/gul_S1_eltcalc_P35
mkfifo fifo/gul_S1_summarycalc_P35
mkfifo fifo/gul_S1_pltcalc_P35

mkfifo fifo/gul_S1_summary_P36
mkfifo fifo/gul_S1_summary_P36.idx
mkfifo fifo/gul_S1_eltcalc_P36
mkfifo fifo/gul_S1_summarycalc_P36
mkfifo fifo/gul_S1_pltcalc_P36

mkfifo fifo/gul_S1_summary_P37
mkfifo fifo/gul_S1_summary_P37.idx
mkfifo fifo/gul_S1_eltcalc_P37
mkfifo fifo/gul_S1_summarycalc_P37
mkfifo fifo/gul_S1_pltcalc_P37

mkfifo fifo/gul_S1_summary_P38
mkfifo fifo/gul_S1_summary_P38.idx
mkfifo fifo/gul_S1_eltcalc_P38
mkfifo fifo/gul_S1_summarycalc_P38
mkfifo fifo/gul_S1_pltcalc_P38

mkfifo fifo/gul_S1_summary_P39
mkfifo fifo/gul_S1_summary_P39.idx
mkfifo fifo/gul_S1_eltcalc_P39
mkfifo fifo/gul_S1_summarycalc_P39
mkfifo fifo/gul_S1_pltcalc_P39

mkfifo fifo/gul_S1_summary_P40
mkfifo fifo/gul_S1_summary_P40.idx
mkfifo fifo/gul_S1_eltcalc_P40
mkfifo fifo/gul_S1_summarycalc_P40
mkfifo fifo/gul_S1_pltcalc_P40

mkfifo fifo/il_P1
mkfifo fifo/il_P2
mkfifo fifo/il_P3
mkfifo fifo/il_P4
mkfifo fifo/il_P5
mkfifo fifo/il_P6
mkfifo fifo/il_P7
mkfifo fifo/il_P8
mkfifo fifo/il_P9
mkfifo fifo/il_P10
mkfifo fifo/il_P11
mkfifo fifo/il_P12
mkfifo fifo/il_P13
mkfifo fifo/il_P14
mkfifo fifo/il_P15
mkfifo fifo/il_P16
mkfifo fifo/il_P17
mkfifo fifo/il_P18
mkfifo fifo/il_P19
mkfifo fifo/il_P20
mkfifo fifo/il_P21
mkfifo fifo/il_P22
mkfifo fifo/il_P23
mkfifo fifo/il_P24
mkfifo fifo/il_P25
mkfifo fifo/il_P26
mkfifo fifo/il_P27
mkfifo fifo/il_P28
mkfifo fifo/il_P29
mkfifo fifo/il_P30
mkfifo fifo/il_P31
mkfifo fifo/il_P32
mkfifo fifo/il_P33
mkfifo fifo/il_P34
mkfifo fifo/il_P35
mkfifo fifo/il_P36
mkfifo fifo/il_P37
mkfifo fifo/il_P38
mkfifo fifo/il_P39
mkfifo fifo/il_P40

mkfifo fifo/il_S1_summary_P1
mkfifo fifo/il_S1_summary_P1.idx
mkfifo fifo/il_S1_eltcalc_P1
mkfifo fifo/il_S1_summarycalc_P1
mkfifo fifo/il_S1_pltcalc_P1

mkfifo fifo/il_S1_summary_P2
mkfifo fifo/il_S1_summary_P2.idx
mkfifo fifo/il_S1_eltcalc_P2
mkfifo fifo/il_S1_summarycalc_P2
mkfifo fifo/il_S1_pltcalc_P2

mkfifo fifo/il_S1_summary_P3
mkfifo fifo/il_S1_summary_P3.idx
mkfifo fifo/il_S1_eltcalc_P3
mkfifo fifo/il_S1_summarycalc_P3
mkfifo fifo/il_S1_pltcalc_P3

mkfifo fifo/il_S1_summary_P4
mkfifo fifo/il_S1_summary_P4.idx
mkfifo fifo/il_S1_eltcalc_P4
mkfifo fifo/il_S1_summarycalc_P4
mkfifo fifo/il_S1_pltcalc_P4

mkfifo fifo/il_S1_summary_P5
mkfifo fifo/il_S1_summary_P5.idx
mkfifo fifo/il_S1_eltcalc_P5
mkfifo fifo/il_S1_summarycalc_P5
mkfifo fifo/il_S1_pltcalc_P5

mkfifo fifo/il_S1_summary_P6
mkfifo fifo/il_S1_summary_P6.idx
mkfifo fifo/il_S1_eltcalc_P6
mkfifo fifo/il_S1_summarycalc_P6
mkfifo fifo/il_S1_pltcalc_P6

mkfifo fifo/il_S1_summary_P7
mkfifo fifo/il_S1_summary_P7.idx
mkfifo fifo/il_S1_eltcalc_P7
mkfifo fifo/il_S1_summarycalc_P7
mkfifo fifo/il_S1_pltcalc_P7

mkfifo fifo/il_S1_summary_P8
mkfifo fifo/il_S1_summary_P8.idx
mkfifo fifo/il_S1_eltcalc_P8
mkfifo fifo/il_S1_summarycalc_P8
mkfifo fifo/il_S1_pltcalc_P8

mkfifo fifo/il_S1_summary_P9
mkfifo fifo/il_S1_summary_P9.idx
mkfifo fifo/il_S1_eltcalc_P9
mkfifo fifo/il_S1_summarycalc_P9
mkfifo fifo/il_S1_pltcalc_P9

mkfifo fifo/il_S1_summary_P10
mkfifo fifo/il_S1_summary_P10.idx
mkfifo fifo/il_S1_eltcalc_P10
mkfifo fifo/il_S1_summarycalc_P10
mkfifo fifo/il_S1_pltcalc_P10

mkfifo fifo/il_S1_summary_P11
mkfifo fifo/il_S1_summary_P11.idx
mkfifo fifo/il_S1_eltcalc_P11
mkfifo fifo/il_S1_summarycalc_P11
mkfifo fifo/il_S1_pltcalc_P11

mkfifo fifo/il_S1_summary_P12
mkfifo fifo/il_S1_summary_P12.idx
mkfifo fifo/il_S1_eltcalc_P12
mkfifo fifo/il_S1_summarycalc_P12
mkfifo fifo/il_S1_pltcalc_P12

mkfifo fifo/il_S1_summary_P13
mkfifo fifo/il_S1_summary_P13.idx
mkfifo fifo/il_S1_eltcalc_P13
mkfifo fifo/il_S1_summarycalc_P13
mkfifo fifo/il_S1_pltcalc_P13

mkfifo fifo/il_S1_summary_P14
mkfifo fifo/il_S1_summary_P14.idx
mkfifo fifo/il_S1_eltcalc_P14
mkfifo fifo/il_S1_summarycalc_P14
mkfifo fifo/il_S1_pltcalc_P14

mkfifo fifo/il_S1_summary_P15
mkfifo fifo/il_S1_summary_P15.idx
mkfifo fifo/il_S1_eltcalc_P15
mkfifo fifo/il_S1_summarycalc_P15
mkfifo fifo/il_S1_pltcalc_P15

mkfifo fifo/il_S1_summary_P16
mkfifo fifo/il_S1_summary_P16.idx
mkfifo fifo/il_S1_eltcalc_P16
mkfifo fifo/il_S1_summarycalc_P16
mkfifo fifo/il_S1_pltcalc_P16

mkfifo fifo/il_S1_summary_P17
mkfifo fifo/il_S1_summary_P17.idx
mkfifo fifo/il_S1_eltcalc_P17
mkfifo fifo/il_S1_summarycalc_P17
mkfifo fifo/il_S1_pltcalc_P17

mkfifo fifo/il_S1_summary_P18
mkfifo fifo/il_S1_summary_P18.idx
mkfifo fifo/il_S1_eltcalc_P18
mkfifo fifo/il_S1_summarycalc_P18
mkfifo fifo/il_S1_pltcalc_P18

mkfifo fifo/il_S1_summary_P19
mkfifo fifo/il_S1_summary_P19.idx
mkfifo fifo/il_S1_eltcalc_P19
mkfifo fifo/il_S1_summarycalc_P19
mkfifo fifo/il_S1_pltcalc_P19

mkfifo fifo/il_S1_summary_P20
mkfifo fifo/il_S1_summary_P20.idx
mkfifo fifo/il_S1_eltcalc_P20
mkfifo fifo/il_S1_summarycalc_P20
mkfifo fifo/il_S1_pltcalc_P20

mkfifo fifo/il_S1_summary_P21
mkfifo fifo/il_S1_summary_P21.idx
mkfifo fifo/il_S1_eltcalc_P21
mkfifo fifo/il_S1_summarycalc_P21
mkfifo fifo/il_S1_pltcalc_P21

mkfifo fifo/il_S1_summary_P22
mkfifo fifo/il_S1_summary_P22.idx
mkfifo fifo/il_S1_eltcalc_P22
mkfifo fifo/il_S1_summarycalc_P22
mkfifo fifo/il_S1_pltcalc_P22

mkfifo fifo/il_S1_summary_P23
mkfifo fifo/il_S1_summary_P23.idx
mkfifo fifo/il_S1_eltcalc_P23
mkfifo fifo/il_S1_summarycalc_P23
mkfifo fifo/il_S1_pltcalc_P23

mkfifo fifo/il_S1_summary_P24
mkfifo fifo/il_S1_summary_P24.idx
mkfifo fifo/il_S1_eltcalc_P24
mkfifo fifo/il_S1_summarycalc_P24
mkfifo fifo/il_S1_pltcalc_P24

mkfifo fifo/il_S1_summary_P25
mkfifo fifo/il_S1_summary_P25.idx
mkfifo fifo/il_S1_eltcalc_P25
mkfifo fifo/il_S1_summarycalc_P25
mkfifo fifo/il_S1_pltcalc_P25

mkfifo fifo/il_S1_summary_P26
mkfifo fifo/il_S1_summary_P26.idx
mkfifo fifo/il_S1_eltcalc_P26
mkfifo fifo/il_S1_summarycalc_P26
mkfifo fifo/il_S1_pltcalc_P26

mkfifo fifo/il_S1_summary_P27
mkfifo fifo/il_S1_summary_P27.idx
mkfifo fifo/il_S1_eltcalc_P27
mkfifo fifo/il_S1_summarycalc_P27
mkfifo fifo/il_S1_pltcalc_P27

mkfifo fifo/il_S1_summary_P28
mkfifo fifo/il_S1_summary_P28.idx
mkfifo fifo/il_S1_eltcalc_P28
mkfifo fifo/il_S1_summarycalc_P28
mkfifo fifo/il_S1_pltcalc_P28

mkfifo fifo/il_S1_summary_P29
mkfifo fifo/il_S1_summary_P29.idx
mkfifo fifo/il_S1_eltcalc_P29
mkfifo fifo/il_S1_summarycalc_P29
mkfifo fifo/il_S1_pltcalc_P29

mkfifo fifo/il_S1_summary_P30
mkfifo fifo/il_S1_summary_P30.idx
mkfifo fifo/il_S1_eltcalc_P30
mkfifo fifo/il_S1_summarycalc_P30
mkfifo fifo/il_S1_pltcalc_P30

mkfifo fifo/il_S1_summary_P31
mkfifo fifo/il_S1_summary_P31.idx
mkfifo fifo/il_S1_eltcalc_P31
mkfifo fifo/il_S1_summarycalc_P31
mkfifo fifo/il_S1_pltcalc_P31

mkfifo fifo/il_S1_summary_P32
mkfifo fifo/il_S1_summary_P32.idx
mkfifo fifo/il_S1_eltcalc_P32
mkfifo fifo/il_S1_summarycalc_P32
mkfifo fifo/il_S1_pltcalc_P32

mkfifo fifo/il_S1_summary_P33
mkfifo fifo/il_S1_summary_P33.idx
mkfifo fifo/il_S1_eltcalc_P33
mkfifo fifo/il_S1_summarycalc_P33
mkfifo fifo/il_S1_pltcalc_P33

mkfifo fifo/il_S1_summary_P34
mkfifo fifo/il_S1_summary_P34.idx
mkfifo fifo/il_S1_eltcalc_P34
mkfifo fifo/il_S1_summarycalc_P34
mkfifo fifo/il_S1_pltcalc_P34

mkfifo fifo/il_S1_summary_P35
mkfifo fifo/il_S1_summary_P35.idx
mkfifo fifo/il_S1_eltcalc_P35
mkfifo fifo/il_S1_summarycalc_P35
mkfifo fifo/il_S1_pltcalc_P35

mkfifo fifo/il_S1_summary_P36
mkfifo fifo/il_S1_summary_P36.idx
mkfifo fifo/il_S1_eltcalc_P36
mkfifo fifo/il_S1_summarycalc_P36
mkfifo fifo/il_S1_pltcalc_P36

mkfifo fifo/il_S1_summary_P37
mkfifo fifo/il_S1_summary_P37.idx
mkfifo fifo/il_S1_eltcalc_P37
mkfifo fifo/il_S1_summarycalc_P37
mkfifo fifo/il_S1_pltcalc_P37

mkfifo fifo/il_S1_summary_P38
mkfifo fifo/il_S1_summary_P38.idx
mkfifo fifo/il_S1_eltcalc_P38
mkfifo fifo/il_S1_summarycalc_P38
mkfifo fifo/il_S1_pltcalc_P38

mkfifo fifo/il_S1_summary_P39
mkfifo fifo/il_S1_summary_P39.idx
mkfifo fifo/il_S1_eltcalc_P39
mkfifo fifo/il_S1_summarycalc_P39
mkfifo fifo/il_S1_pltcalc_P39

mkfifo fifo/il_S1_summary_P40
mkfifo fifo/il_S1_summary_P40.idx
mkfifo fifo/il_S1_eltcalc_P40
mkfifo fifo/il_S1_summarycalc_P40
mkfifo fifo/il_S1_pltcalc_P40

mkfifo fifo/full_correlation/gul_P1
mkfifo fifo/full_correlation/gul_P2
mkfifo fifo/full_correlation/gul_P3
mkfifo fifo/full_correlation/gul_P4
mkfifo fifo/full_correlation/gul_P5
mkfifo fifo/full_correlation/gul_P6
mkfifo fifo/full_correlation/gul_P7
mkfifo fifo/full_correlation/gul_P8
mkfifo fifo/full_correlation/gul_P9
mkfifo fifo/full_correlation/gul_P10
mkfifo fifo/full_correlation/gul_P11
mkfifo fifo/full_correlation/gul_P12
mkfifo fifo/full_correlation/gul_P13
mkfifo fifo/full_correlation/gul_P14
mkfifo fifo/full_correlation/gul_P15
mkfifo fifo/full_correlation/gul_P16
mkfifo fifo/full_correlation/gul_P17
mkfifo fifo/full_correlation/gul_P18
mkfifo fifo/full_correlation/gul_P19
mkfifo fifo/full_correlation/gul_P20
mkfifo fifo/full_correlation/gul_P21
mkfifo fifo/full_correlation/gul_P22
mkfifo fifo/full_correlation/gul_P23
mkfifo fifo/full_correlation/gul_P24
mkfifo fifo/full_correlation/gul_P25
mkfifo fifo/full_correlation/gul_P26
mkfifo fifo/full_correlation/gul_P27
mkfifo fifo/full_correlation/gul_P28
mkfifo fifo/full_correlation/gul_P29
mkfifo fifo/full_correlation/gul_P30
mkfifo fifo/full_correlation/gul_P31
mkfifo fifo/full_correlation/gul_P32
mkfifo fifo/full_correlation/gul_P33
mkfifo fifo/full_correlation/gul_P34
mkfifo fifo/full_correlation/gul_P35
mkfifo fifo/full_correlation/gul_P36
mkfifo fifo/full_correlation/gul_P37
mkfifo fifo/full_correlation/gul_P38
mkfifo fifo/full_correlation/gul_P39
mkfifo fifo/full_correlation/gul_P40

mkfifo fifo/full_correlation/gul_S1_summary_P1
mkfifo fifo/full_correlation/gul_S1_summary_P1.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P1
mkfifo fifo/full_correlation/gul_S1_summarycalc_P1
mkfifo fifo/full_correlation/gul_S1_pltcalc_P1

mkfifo fifo/full_correlation/gul_S1_summary_P2
mkfifo fifo/full_correlation/gul_S1_summary_P2.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P2
mkfifo fifo/full_correlation/gul_S1_summarycalc_P2
mkfifo fifo/full_correlation/gul_S1_pltcalc_P2

mkfifo fifo/full_correlation/gul_S1_summary_P3
mkfifo fifo/full_correlation/gul_S1_summary_P3.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P3
mkfifo fifo/full_correlation/gul_S1_summarycalc_P3
mkfifo fifo/full_correlation/gul_S1_pltcalc_P3

mkfifo fifo/full_correlation/gul_S1_summary_P4
mkfifo fifo/full_correlation/gul_S1_summary_P4.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P4
mkfifo fifo/full_correlation/gul_S1_summarycalc_P4
mkfifo fifo/full_correlation/gul_S1_pltcalc_P4

mkfifo fifo/full_correlation/gul_S1_summary_P5
mkfifo fifo/full_correlation/gul_S1_summary_P5.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P5
mkfifo fifo/full_correlation/gul_S1_summarycalc_P5
mkfifo fifo/full_correlation/gul_S1_pltcalc_P5

mkfifo fifo/full_correlation/gul_S1_summary_P6
mkfifo fifo/full_correlation/gul_S1_summary_P6.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P6
mkfifo fifo/full_correlation/gul_S1_summarycalc_P6
mkfifo fifo/full_correlation/gul_S1_pltcalc_P6

mkfifo fifo/full_correlation/gul_S1_summary_P7
mkfifo fifo/full_correlation/gul_S1_summary_P7.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P7
mkfifo fifo/full_correlation/gul_S1_summarycalc_P7
mkfifo fifo/full_correlation/gul_S1_pltcalc_P7

mkfifo fifo/full_correlation/gul_S1_summary_P8
mkfifo fifo/full_correlation/gul_S1_summary_P8.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P8
mkfifo fifo/full_correlation/gul_S1_summarycalc_P8
mkfifo fifo/full_correlation/gul_S1_pltcalc_P8

mkfifo fifo/full_correlation/gul_S1_summary_P9
mkfifo fifo/full_correlation/gul_S1_summary_P9.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P9
mkfifo fifo/full_correlation/gul_S1_summarycalc_P9
mkfifo fifo/full_correlation/gul_S1_pltcalc_P9

mkfifo fifo/full_correlation/gul_S1_summary_P10
mkfifo fifo/full_correlation/gul_S1_summary_P10.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P10
mkfifo fifo/full_correlation/gul_S1_summarycalc_P10
mkfifo fifo/full_correlation/gul_S1_pltcalc_P10

mkfifo fifo/full_correlation/gul_S1_summary_P11
mkfifo fifo/full_correlation/gul_S1_summary_P11.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P11
mkfifo fifo/full_correlation/gul_S1_summarycalc_P11
mkfifo fifo/full_correlation/gul_S1_pltcalc_P11

mkfifo fifo/full_correlation/gul_S1_summary_P12
mkfifo fifo/full_correlation/gul_S1_summary_P12.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P12
mkfifo fifo/full_correlation/gul_S1_summarycalc_P12
mkfifo fifo/full_correlation/gul_S1_pltcalc_P12

mkfifo fifo/full_correlation/gul_S1_summary_P13
mkfifo fifo/full_correlation/gul_S1_summary_P13.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P13
mkfifo fifo/full_correlation/gul_S1_summarycalc_P13
mkfifo fifo/full_correlation/gul_S1_pltcalc_P13

mkfifo fifo/full_correlation/gul_S1_summary_P14
mkfifo fifo/full_correlation/gul_S1_summary_P14.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P14
mkfifo fifo/full_correlation/gul_S1_summarycalc_P14
mkfifo fifo/full_correlation/gul_S1_pltcalc_P14

mkfifo fifo/full_correlation/gul_S1_summary_P15
mkfifo fifo/full_correlation/gul_S1_summary_P15.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P15
mkfifo fifo/full_correlation/gul_S1_summarycalc_P15
mkfifo fifo/full_correlation/gul_S1_pltcalc_P15

mkfifo fifo/full_correlation/gul_S1_summary_P16
mkfifo fifo/full_correlation/gul_S1_summary_P16.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P16
mkfifo fifo/full_correlation/gul_S1_summarycalc_P16
mkfifo fifo/full_correlation/gul_S1_pltcalc_P16

mkfifo fifo/full_correlation/gul_S1_summary_P17
mkfifo fifo/full_correlation/gul_S1_summary_P17.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P17
mkfifo fifo/full_correlation/gul_S1_summarycalc_P17
mkfifo fifo/full_correlation/gul_S1_pltcalc_P17

mkfifo fifo/full_correlation/gul_S1_summary_P18
mkfifo fifo/full_correlation/gul_S1_summary_P18.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P18
mkfifo fifo/full_correlation/gul_S1_summarycalc_P18
mkfifo fifo/full_correlation/gul_S1_pltcalc_P18

mkfifo fifo/full_correlation/gul_S1_summary_P19
mkfifo fifo/full_correlation/gul_S1_summary_P19.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P19
mkfifo fifo/full_correlation/gul_S1_summarycalc_P19
mkfifo fifo/full_correlation/gul_S1_pltcalc_P19

mkfifo fifo/full_correlation/gul_S1_summary_P20
mkfifo fifo/full_correlation/gul_S1_summary_P20.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P20
mkfifo fifo/full_correlation/gul_S1_summarycalc_P20
mkfifo fifo/full_correlation/gul_S1_pltcalc_P20

mkfifo fifo/full_correlation/gul_S1_summary_P21
mkfifo fifo/full_correlation/gul_S1_summary_P21.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P21
mkfifo fifo/full_correlation/gul_S1_summarycalc_P21
mkfifo fifo/full_correlation/gul_S1_pltcalc_P21

mkfifo fifo/full_correlation/gul_S1_summary_P22
mkfifo fifo/full_correlation/gul_S1_summary_P22.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P22
mkfifo fifo/full_correlation/gul_S1_summarycalc_P22
mkfifo fifo/full_correlation/gul_S1_pltcalc_P22

mkfifo fifo/full_correlation/gul_S1_summary_P23
mkfifo fifo/full_correlation/gul_S1_summary_P23.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P23
mkfifo fifo/full_correlation/gul_S1_summarycalc_P23
mkfifo fifo/full_correlation/gul_S1_pltcalc_P23

mkfifo fifo/full_correlation/gul_S1_summary_P24
mkfifo fifo/full_correlation/gul_S1_summary_P24.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P24
mkfifo fifo/full_correlation/gul_S1_summarycalc_P24
mkfifo fifo/full_correlation/gul_S1_pltcalc_P24

mkfifo fifo/full_correlation/gul_S1_summary_P25
mkfifo fifo/full_correlation/gul_S1_summary_P25.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P25
mkfifo fifo/full_correlation/gul_S1_summarycalc_P25
mkfifo fifo/full_correlation/gul_S1_pltcalc_P25

mkfifo fifo/full_correlation/gul_S1_summary_P26
mkfifo fifo/full_correlation/gul_S1_summary_P26.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P26
mkfifo fifo/full_correlation/gul_S1_summarycalc_P26
mkfifo fifo/full_correlation/gul_S1_pltcalc_P26

mkfifo fifo/full_correlation/gul_S1_summary_P27
mkfifo fifo/full_correlation/gul_S1_summary_P27.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P27
mkfifo fifo/full_correlation/gul_S1_summarycalc_P27
mkfifo fifo/full_correlation/gul_S1_pltcalc_P27

mkfifo fifo/full_correlation/gul_S1_summary_P28
mkfifo fifo/full_correlation/gul_S1_summary_P28.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P28
mkfifo fifo/full_correlation/gul_S1_summarycalc_P28
mkfifo fifo/full_correlation/gul_S1_pltcalc_P28

mkfifo fifo/full_correlation/gul_S1_summary_P29
mkfifo fifo/full_correlation/gul_S1_summary_P29.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P29
mkfifo fifo/full_correlation/gul_S1_summarycalc_P29
mkfifo fifo/full_correlation/gul_S1_pltcalc_P29

mkfifo fifo/full_correlation/gul_S1_summary_P30
mkfifo fifo/full_correlation/gul_S1_summary_P30.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P30
mkfifo fifo/full_correlation/gul_S1_summarycalc_P30
mkfifo fifo/full_correlation/gul_S1_pltcalc_P30

mkfifo fifo/full_correlation/gul_S1_summary_P31
mkfifo fifo/full_correlation/gul_S1_summary_P31.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P31
mkfifo fifo/full_correlation/gul_S1_summarycalc_P31
mkfifo fifo/full_correlation/gul_S1_pltcalc_P31

mkfifo fifo/full_correlation/gul_S1_summary_P32
mkfifo fifo/full_correlation/gul_S1_summary_P32.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P32
mkfifo fifo/full_correlation/gul_S1_summarycalc_P32
mkfifo fifo/full_correlation/gul_S1_pltcalc_P32

mkfifo fifo/full_correlation/gul_S1_summary_P33
mkfifo fifo/full_correlation/gul_S1_summary_P33.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P33
mkfifo fifo/full_correlation/gul_S1_summarycalc_P33
mkfifo fifo/full_correlation/gul_S1_pltcalc_P33

mkfifo fifo/full_correlation/gul_S1_summary_P34
mkfifo fifo/full_correlation/gul_S1_summary_P34.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P34
mkfifo fifo/full_correlation/gul_S1_summarycalc_P34
mkfifo fifo/full_correlation/gul_S1_pltcalc_P34

mkfifo fifo/full_correlation/gul_S1_summary_P35
mkfifo fifo/full_correlation/gul_S1_summary_P35.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P35
mkfifo fifo/full_correlation/gul_S1_summarycalc_P35
mkfifo fifo/full_correlation/gul_S1_pltcalc_P35

mkfifo fifo/full_correlation/gul_S1_summary_P36
mkfifo fifo/full_correlation/gul_S1_summary_P36.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P36
mkfifo fifo/full_correlation/gul_S1_summarycalc_P36
mkfifo fifo/full_correlation/gul_S1_pltcalc_P36

mkfifo fifo/full_correlation/gul_S1_summary_P37
mkfifo fifo/full_correlation/gul_S1_summary_P37.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P37
mkfifo fifo/full_correlation/gul_S1_summarycalc_P37
mkfifo fifo/full_correlation/gul_S1_pltcalc_P37

mkfifo fifo/full_correlation/gul_S1_summary_P38
mkfifo fifo/full_correlation/gul_S1_summary_P38.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P38
mkfifo fifo/full_correlation/gul_S1_summarycalc_P38
mkfifo fifo/full_correlation/gul_S1_pltcalc_P38

mkfifo fifo/full_correlation/gul_S1_summary_P39
mkfifo fifo/full_correlation/gul_S1_summary_P39.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P39
mkfifo fifo/full_correlation/gul_S1_summarycalc_P39
mkfifo fifo/full_correlation/gul_S1_pltcalc_P39

mkfifo fifo/full_correlation/gul_S1_summary_P40
mkfifo fifo/full_correlation/gul_S1_summary_P40.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P40
mkfifo fifo/full_correlation/gul_S1_summarycalc_P40
mkfifo fifo/full_correlation/gul_S1_pltcalc_P40

mkfifo fifo/full_correlation/il_P1
mkfifo fifo/full_correlation/il_P2
mkfifo fifo/full_correlation/il_P3
mkfifo fifo/full_correlation/il_P4
mkfifo fifo/full_correlation/il_P5
mkfifo fifo/full_correlation/il_P6
mkfifo fifo/full_correlation/il_P7
mkfifo fifo/full_correlation/il_P8
mkfifo fifo/full_correlation/il_P9
mkfifo fifo/full_correlation/il_P10
mkfifo fifo/full_correlation/il_P11
mkfifo fifo/full_correlation/il_P12
mkfifo fifo/full_correlation/il_P13
mkfifo fifo/full_correlation/il_P14
mkfifo fifo/full_correlation/il_P15
mkfifo fifo/full_correlation/il_P16
mkfifo fifo/full_correlation/il_P17
mkfifo fifo/full_correlation/il_P18
mkfifo fifo/full_correlation/il_P19
mkfifo fifo/full_correlation/il_P20
mkfifo fifo/full_correlation/il_P21
mkfifo fifo/full_correlation/il_P22
mkfifo fifo/full_correlation/il_P23
mkfifo fifo/full_correlation/il_P24
mkfifo fifo/full_correlation/il_P25
mkfifo fifo/full_correlation/il_P26
mkfifo fifo/full_correlation/il_P27
mkfifo fifo/full_correlation/il_P28
mkfifo fifo/full_correlation/il_P29
mkfifo fifo/full_correlation/il_P30
mkfifo fifo/full_correlation/il_P31
mkfifo fifo/full_correlation/il_P32
mkfifo fifo/full_correlation/il_P33
mkfifo fifo/full_correlation/il_P34
mkfifo fifo/full_correlation/il_P35
mkfifo fifo/full_correlation/il_P36
mkfifo fifo/full_correlation/il_P37
mkfifo fifo/full_correlation/il_P38
mkfifo fifo/full_correlation/il_P39
mkfifo fifo/full_correlation/il_P40

mkfifo fifo/full_correlation/il_S1_summary_P1
mkfifo fifo/full_correlation/il_S1_summary_P1.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P1
mkfifo fifo/full_correlation/il_S1_summarycalc_P1
mkfifo fifo/full_correlation/il_S1_pltcalc_P1

mkfifo fifo/full_correlation/il_S1_summary_P2
mkfifo fifo/full_correlation/il_S1_summary_P2.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P2
mkfifo fifo/full_correlation/il_S1_summarycalc_P2
mkfifo fifo/full_correlation/il_S1_pltcalc_P2

mkfifo fifo/full_correlation/il_S1_summary_P3
mkfifo fifo/full_correlation/il_S1_summary_P3.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P3
mkfifo fifo/full_correlation/il_S1_summarycalc_P3
mkfifo fifo/full_correlation/il_S1_pltcalc_P3

mkfifo fifo/full_correlation/il_S1_summary_P4
mkfifo fifo/full_correlation/il_S1_summary_P4.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P4
mkfifo fifo/full_correlation/il_S1_summarycalc_P4
mkfifo fifo/full_correlation/il_S1_pltcalc_P4

mkfifo fifo/full_correlation/il_S1_summary_P5
mkfifo fifo/full_correlation/il_S1_summary_P5.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P5
mkfifo fifo/full_correlation/il_S1_summarycalc_P5
mkfifo fifo/full_correlation/il_S1_pltcalc_P5

mkfifo fifo/full_correlation/il_S1_summary_P6
mkfifo fifo/full_correlation/il_S1_summary_P6.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P6
mkfifo fifo/full_correlation/il_S1_summarycalc_P6
mkfifo fifo/full_correlation/il_S1_pltcalc_P6

mkfifo fifo/full_correlation/il_S1_summary_P7
mkfifo fifo/full_correlation/il_S1_summary_P7.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P7
mkfifo fifo/full_correlation/il_S1_summarycalc_P7
mkfifo fifo/full_correlation/il_S1_pltcalc_P7

mkfifo fifo/full_correlation/il_S1_summary_P8
mkfifo fifo/full_correlation/il_S1_summary_P8.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P8
mkfifo fifo/full_correlation/il_S1_summarycalc_P8
mkfifo fifo/full_correlation/il_S1_pltcalc_P8

mkfifo fifo/full_correlation/il_S1_summary_P9
mkfifo fifo/full_correlation/il_S1_summary_P9.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P9
mkfifo fifo/full_correlation/il_S1_summarycalc_P9
mkfifo fifo/full_correlation/il_S1_pltcalc_P9

mkfifo fifo/full_correlation/il_S1_summary_P10
mkfifo fifo/full_correlation/il_S1_summary_P10.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P10
mkfifo fifo/full_correlation/il_S1_summarycalc_P10
mkfifo fifo/full_correlation/il_S1_pltcalc_P10

mkfifo fifo/full_correlation/il_S1_summary_P11
mkfifo fifo/full_correlation/il_S1_summary_P11.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P11
mkfifo fifo/full_correlation/il_S1_summarycalc_P11
mkfifo fifo/full_correlation/il_S1_pltcalc_P11

mkfifo fifo/full_correlation/il_S1_summary_P12
mkfifo fifo/full_correlation/il_S1_summary_P12.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P12
mkfifo fifo/full_correlation/il_S1_summarycalc_P12
mkfifo fifo/full_correlation/il_S1_pltcalc_P12

mkfifo fifo/full_correlation/il_S1_summary_P13
mkfifo fifo/full_correlation/il_S1_summary_P13.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P13
mkfifo fifo/full_correlation/il_S1_summarycalc_P13
mkfifo fifo/full_correlation/il_S1_pltcalc_P13

mkfifo fifo/full_correlation/il_S1_summary_P14
mkfifo fifo/full_correlation/il_S1_summary_P14.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P14
mkfifo fifo/full_correlation/il_S1_summarycalc_P14
mkfifo fifo/full_correlation/il_S1_pltcalc_P14

mkfifo fifo/full_correlation/il_S1_summary_P15
mkfifo fifo/full_correlation/il_S1_summary_P15.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P15
mkfifo fifo/full_correlation/il_S1_summarycalc_P15
mkfifo fifo/full_correlation/il_S1_pltcalc_P15

mkfifo fifo/full_correlation/il_S1_summary_P16
mkfifo fifo/full_correlation/il_S1_summary_P16.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P16
mkfifo fifo/full_correlation/il_S1_summarycalc_P16
mkfifo fifo/full_correlation/il_S1_pltcalc_P16

mkfifo fifo/full_correlation/il_S1_summary_P17
mkfifo fifo/full_correlation/il_S1_summary_P17.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P17
mkfifo fifo/full_correlation/il_S1_summarycalc_P17
mkfifo fifo/full_correlation/il_S1_pltcalc_P17

mkfifo fifo/full_correlation/il_S1_summary_P18
mkfifo fifo/full_correlation/il_S1_summary_P18.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P18
mkfifo fifo/full_correlation/il_S1_summarycalc_P18
mkfifo fifo/full_correlation/il_S1_pltcalc_P18

mkfifo fifo/full_correlation/il_S1_summary_P19
mkfifo fifo/full_correlation/il_S1_summary_P19.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P19
mkfifo fifo/full_correlation/il_S1_summarycalc_P19
mkfifo fifo/full_correlation/il_S1_pltcalc_P19

mkfifo fifo/full_correlation/il_S1_summary_P20
mkfifo fifo/full_correlation/il_S1_summary_P20.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P20
mkfifo fifo/full_correlation/il_S1_summarycalc_P20
mkfifo fifo/full_correlation/il_S1_pltcalc_P20

mkfifo fifo/full_correlation/il_S1_summary_P21
mkfifo fifo/full_correlation/il_S1_summary_P21.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P21
mkfifo fifo/full_correlation/il_S1_summarycalc_P21
mkfifo fifo/full_correlation/il_S1_pltcalc_P21

mkfifo fifo/full_correlation/il_S1_summary_P22
mkfifo fifo/full_correlation/il_S1_summary_P22.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P22
mkfifo fifo/full_correlation/il_S1_summarycalc_P22
mkfifo fifo/full_correlation/il_S1_pltcalc_P22

mkfifo fifo/full_correlation/il_S1_summary_P23
mkfifo fifo/full_correlation/il_S1_summary_P23.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P23
mkfifo fifo/full_correlation/il_S1_summarycalc_P23
mkfifo fifo/full_correlation/il_S1_pltcalc_P23

mkfifo fifo/full_correlation/il_S1_summary_P24
mkfifo fifo/full_correlation/il_S1_summary_P24.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P24
mkfifo fifo/full_correlation/il_S1_summarycalc_P24
mkfifo fifo/full_correlation/il_S1_pltcalc_P24

mkfifo fifo/full_correlation/il_S1_summary_P25
mkfifo fifo/full_correlation/il_S1_summary_P25.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P25
mkfifo fifo/full_correlation/il_S1_summarycalc_P25
mkfifo fifo/full_correlation/il_S1_pltcalc_P25

mkfifo fifo/full_correlation/il_S1_summary_P26
mkfifo fifo/full_correlation/il_S1_summary_P26.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P26
mkfifo fifo/full_correlation/il_S1_summarycalc_P26
mkfifo fifo/full_correlation/il_S1_pltcalc_P26

mkfifo fifo/full_correlation/il_S1_summary_P27
mkfifo fifo/full_correlation/il_S1_summary_P27.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P27
mkfifo fifo/full_correlation/il_S1_summarycalc_P27
mkfifo fifo/full_correlation/il_S1_pltcalc_P27

mkfifo fifo/full_correlation/il_S1_summary_P28
mkfifo fifo/full_correlation/il_S1_summary_P28.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P28
mkfifo fifo/full_correlation/il_S1_summarycalc_P28
mkfifo fifo/full_correlation/il_S1_pltcalc_P28

mkfifo fifo/full_correlation/il_S1_summary_P29
mkfifo fifo/full_correlation/il_S1_summary_P29.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P29
mkfifo fifo/full_correlation/il_S1_summarycalc_P29
mkfifo fifo/full_correlation/il_S1_pltcalc_P29

mkfifo fifo/full_correlation/il_S1_summary_P30
mkfifo fifo/full_correlation/il_S1_summary_P30.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P30
mkfifo fifo/full_correlation/il_S1_summarycalc_P30
mkfifo fifo/full_correlation/il_S1_pltcalc_P30

mkfifo fifo/full_correlation/il_S1_summary_P31
mkfifo fifo/full_correlation/il_S1_summary_P31.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P31
mkfifo fifo/full_correlation/il_S1_summarycalc_P31
mkfifo fifo/full_correlation/il_S1_pltcalc_P31

mkfifo fifo/full_correlation/il_S1_summary_P32
mkfifo fifo/full_correlation/il_S1_summary_P32.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P32
mkfifo fifo/full_correlation/il_S1_summarycalc_P32
mkfifo fifo/full_correlation/il_S1_pltcalc_P32

mkfifo fifo/full_correlation/il_S1_summary_P33
mkfifo fifo/full_correlation/il_S1_summary_P33.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P33
mkfifo fifo/full_correlation/il_S1_summarycalc_P33
mkfifo fifo/full_correlation/il_S1_pltcalc_P33

mkfifo fifo/full_correlation/il_S1_summary_P34
mkfifo fifo/full_correlation/il_S1_summary_P34.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P34
mkfifo fifo/full_correlation/il_S1_summarycalc_P34
mkfifo fifo/full_correlation/il_S1_pltcalc_P34

mkfifo fifo/full_correlation/il_S1_summary_P35
mkfifo fifo/full_correlation/il_S1_summary_P35.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P35
mkfifo fifo/full_correlation/il_S1_summarycalc_P35
mkfifo fifo/full_correlation/il_S1_pltcalc_P35

mkfifo fifo/full_correlation/il_S1_summary_P36
mkfifo fifo/full_correlation/il_S1_summary_P36.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P36
mkfifo fifo/full_correlation/il_S1_summarycalc_P36
mkfifo fifo/full_correlation/il_S1_pltcalc_P36

mkfifo fifo/full_correlation/il_S1_summary_P37
mkfifo fifo/full_correlation/il_S1_summary_P37.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P37
mkfifo fifo/full_correlation/il_S1_summarycalc_P37
mkfifo fifo/full_correlation/il_S1_pltcalc_P37

mkfifo fifo/full_correlation/il_S1_summary_P38
mkfifo fifo/full_correlation/il_S1_summary_P38.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P38
mkfifo fifo/full_correlation/il_S1_summarycalc_P38
mkfifo fifo/full_correlation/il_S1_pltcalc_P38

mkfifo fifo/full_correlation/il_S1_summary_P39
mkfifo fifo/full_correlation/il_S1_summary_P39.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P39
mkfifo fifo/full_correlation/il_S1_summarycalc_P39
mkfifo fifo/full_correlation/il_S1_pltcalc_P39

mkfifo fifo/full_correlation/il_S1_summary_P40
mkfifo fifo/full_correlation/il_S1_summary_P40.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P40
mkfifo fifo/full_correlation/il_S1_summarycalc_P40
mkfifo fifo/full_correlation/il_S1_pltcalc_P40



# --- Do insured loss computes ---

eltcalc < fifo/il_S1_eltcalc_P1 > work/kat/il_S1_eltcalc_P1 & pid1=$!
summarycalctocsv < fifo/il_S1_summarycalc_P1 > work/kat/il_S1_summarycalc_P1 & pid2=$!
pltcalc < fifo/il_S1_pltcalc_P1 > work/kat/il_S1_pltcalc_P1 & pid3=$!
eltcalc -s < fifo/il_S1_eltcalc_P2 > work/kat/il_S1_eltcalc_P2 & pid4=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P2 > work/kat/il_S1_summarycalc_P2 & pid5=$!
pltcalc -H < fifo/il_S1_pltcalc_P2 > work/kat/il_S1_pltcalc_P2 & pid6=$!
eltcalc -s < fifo/il_S1_eltcalc_P3 > work/kat/il_S1_eltcalc_P3 & pid7=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P3 > work/kat/il_S1_summarycalc_P3 & pid8=$!
pltcalc -H < fifo/il_S1_pltcalc_P3 > work/kat/il_S1_pltcalc_P3 & pid9=$!
eltcalc -s < fifo/il_S1_eltcalc_P4 > work/kat/il_S1_eltcalc_P4 & pid10=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P4 > work/kat/il_S1_summarycalc_P4 & pid11=$!
pltcalc -H < fifo/il_S1_pltcalc_P4 > work/kat/il_S1_pltcalc_P4 & pid12=$!
eltcalc -s < fifo/il_S1_eltcalc_P5 > work/kat/il_S1_eltcalc_P5 & pid13=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P5 > work/kat/il_S1_summarycalc_P5 & pid14=$!
pltcalc -H < fifo/il_S1_pltcalc_P5 > work/kat/il_S1_pltcalc_P5 & pid15=$!
eltcalc -s < fifo/il_S1_eltcalc_P6 > work/kat/il_S1_eltcalc_P6 & pid16=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P6 > work/kat/il_S1_summarycalc_P6 & pid17=$!
pltcalc -H < fifo/il_S1_pltcalc_P6 > work/kat/il_S1_pltcalc_P6 & pid18=$!
eltcalc -s < fifo/il_S1_eltcalc_P7 > work/kat/il_S1_eltcalc_P7 & pid19=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P7 > work/kat/il_S1_summarycalc_P7 & pid20=$!
pltcalc -H < fifo/il_S1_pltcalc_P7 > work/kat/il_S1_pltcalc_P7 & pid21=$!
eltcalc -s < fifo/il_S1_eltcalc_P8 > work/kat/il_S1_eltcalc_P8 & pid22=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P8 > work/kat/il_S1_summarycalc_P8 & pid23=$!
pltcalc -H < fifo/il_S1_pltcalc_P8 > work/kat/il_S1_pltcalc_P8 & pid24=$!
eltcalc -s < fifo/il_S1_eltcalc_P9 > work/kat/il_S1_eltcalc_P9 & pid25=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P9 > work/kat/il_S1_summarycalc_P9 & pid26=$!
pltcalc -H < fifo/il_S1_pltcalc_P9 > work/kat/il_S1_pltcalc_P9 & pid27=$!
eltcalc -s < fifo/il_S1_eltcalc_P10 > work/kat/il_S1_eltcalc_P10 & pid28=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P10 > work/kat/il_S1_summarycalc_P10 & pid29=$!
pltcalc -H < fifo/il_S1_pltcalc_P10 > work/kat/il_S1_pltcalc_P10 & pid30=$!
eltcalc -s < fifo/il_S1_eltcalc_P11 > work/kat/il_S1_eltcalc_P11 & pid31=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P11 > work/kat/il_S1_summarycalc_P11 & pid32=$!
pltcalc -H < fifo/il_S1_pltcalc_P11 > work/kat/il_S1_pltcalc_P11 & pid33=$!
eltcalc -s < fifo/il_S1_eltcalc_P12 > work/kat/il_S1_eltcalc_P12 & pid34=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P12 > work/kat/il_S1_summarycalc_P12 & pid35=$!
pltcalc -H < fifo/il_S1_pltcalc_P12 > work/kat/il_S1_pltcalc_P12 & pid36=$!
eltcalc -s < fifo/il_S1_eltcalc_P13 > work/kat/il_S1_eltcalc_P13 & pid37=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P13 > work/kat/il_S1_summarycalc_P13 & pid38=$!
pltcalc -H < fifo/il_S1_pltcalc_P13 > work/kat/il_S1_pltcalc_P13 & pid39=$!
eltcalc -s < fifo/il_S1_eltcalc_P14 > work/kat/il_S1_eltcalc_P14 & pid40=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P14 > work/kat/il_S1_summarycalc_P14 & pid41=$!
pltcalc -H < fifo/il_S1_pltcalc_P14 > work/kat/il_S1_pltcalc_P14 & pid42=$!
eltcalc -s < fifo/il_S1_eltcalc_P15 > work/kat/il_S1_eltcalc_P15 & pid43=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P15 > work/kat/il_S1_summarycalc_P15 & pid44=$!
pltcalc -H < fifo/il_S1_pltcalc_P15 > work/kat/il_S1_pltcalc_P15 & pid45=$!
eltcalc -s < fifo/il_S1_eltcalc_P16 > work/kat/il_S1_eltcalc_P16 & pid46=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P16 > work/kat/il_S1_summarycalc_P16 & pid47=$!
pltcalc -H < fifo/il_S1_pltcalc_P16 > work/kat/il_S1_pltcalc_P16 & pid48=$!
eltcalc -s < fifo/il_S1_eltcalc_P17 > work/kat/il_S1_eltcalc_P17 & pid49=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P17 > work/kat/il_S1_summarycalc_P17 & pid50=$!
pltcalc -H < fifo/il_S1_pltcalc_P17 > work/kat/il_S1_pltcalc_P17 & pid51=$!
eltcalc -s < fifo/il_S1_eltcalc_P18 > work/kat/il_S1_eltcalc_P18 & pid52=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P18 > work/kat/il_S1_summarycalc_P18 & pid53=$!
pltcalc -H < fifo/il_S1_pltcalc_P18 > work/kat/il_S1_pltcalc_P18 & pid54=$!
eltcalc -s < fifo/il_S1_eltcalc_P19 > work/kat/il_S1_eltcalc_P19 & pid55=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P19 > work/kat/il_S1_summarycalc_P19 & pid56=$!
pltcalc -H < fifo/il_S1_pltcalc_P19 > work/kat/il_S1_pltcalc_P19 & pid57=$!
eltcalc -s < fifo/il_S1_eltcalc_P20 > work/kat/il_S1_eltcalc_P20 & pid58=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P20 > work/kat/il_S1_summarycalc_P20 & pid59=$!
pltcalc -H < fifo/il_S1_pltcalc_P20 > work/kat/il_S1_pltcalc_P20 & pid60=$!
eltcalc -s < fifo/il_S1_eltcalc_P21 > work/kat/il_S1_eltcalc_P21 & pid61=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P21 > work/kat/il_S1_summarycalc_P21 & pid62=$!
pltcalc -H < fifo/il_S1_pltcalc_P21 > work/kat/il_S1_pltcalc_P21 & pid63=$!
eltcalc -s < fifo/il_S1_eltcalc_P22 > work/kat/il_S1_eltcalc_P22 & pid64=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P22 > work/kat/il_S1_summarycalc_P22 & pid65=$!
pltcalc -H < fifo/il_S1_pltcalc_P22 > work/kat/il_S1_pltcalc_P22 & pid66=$!
eltcalc -s < fifo/il_S1_eltcalc_P23 > work/kat/il_S1_eltcalc_P23 & pid67=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P23 > work/kat/il_S1_summarycalc_P23 & pid68=$!
pltcalc -H < fifo/il_S1_pltcalc_P23 > work/kat/il_S1_pltcalc_P23 & pid69=$!
eltcalc -s < fifo/il_S1_eltcalc_P24 > work/kat/il_S1_eltcalc_P24 & pid70=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P24 > work/kat/il_S1_summarycalc_P24 & pid71=$!
pltcalc -H < fifo/il_S1_pltcalc_P24 > work/kat/il_S1_pltcalc_P24 & pid72=$!
eltcalc -s < fifo/il_S1_eltcalc_P25 > work/kat/il_S1_eltcalc_P25 & pid73=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P25 > work/kat/il_S1_summarycalc_P25 & pid74=$!
pltcalc -H < fifo/il_S1_pltcalc_P25 > work/kat/il_S1_pltcalc_P25 & pid75=$!
eltcalc -s < fifo/il_S1_eltcalc_P26 > work/kat/il_S1_eltcalc_P26 & pid76=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P26 > work/kat/il_S1_summarycalc_P26 & pid77=$!
pltcalc -H < fifo/il_S1_pltcalc_P26 > work/kat/il_S1_pltcalc_P26 & pid78=$!
eltcalc -s < fifo/il_S1_eltcalc_P27 > work/kat/il_S1_eltcalc_P27 & pid79=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P27 > work/kat/il_S1_summarycalc_P27 & pid80=$!
pltcalc -H < fifo/il_S1_pltcalc_P27 > work/kat/il_S1_pltcalc_P27 & pid81=$!
eltcalc -s < fifo/il_S1_eltcalc_P28 > work/kat/il_S1_eltcalc_P28 & pid82=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P28 > work/kat/il_S1_summarycalc_P28 & pid83=$!
pltcalc -H < fifo/il_S1_pltcalc_P28 > work/kat/il_S1_pltcalc_P28 & pid84=$!
eltcalc -s < fifo/il_S1_eltcalc_P29 > work/kat/il_S1_eltcalc_P29 & pid85=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P29 > work/kat/il_S1_summarycalc_P29 & pid86=$!
pltcalc -H < fifo/il_S1_pltcalc_P29 > work/kat/il_S1_pltcalc_P29 & pid87=$!
eltcalc -s < fifo/il_S1_eltcalc_P30 > work/kat/il_S1_eltcalc_P30 & pid88=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P30 > work/kat/il_S1_summarycalc_P30 & pid89=$!
pltcalc -H < fifo/il_S1_pltcalc_P30 > work/kat/il_S1_pltcalc_P30 & pid90=$!
eltcalc -s < fifo/il_S1_eltcalc_P31 > work/kat/il_S1_eltcalc_P31 & pid91=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P31 > work/kat/il_S1_summarycalc_P31 & pid92=$!
pltcalc -H < fifo/il_S1_pltcalc_P31 > work/kat/il_S1_pltcalc_P31 & pid93=$!
eltcalc -s < fifo/il_S1_eltcalc_P32 > work/kat/il_S1_eltcalc_P32 & pid94=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P32 > work/kat/il_S1_summarycalc_P32 & pid95=$!
pltcalc -H < fifo/il_S1_pltcalc_P32 > work/kat/il_S1_pltcalc_P32 & pid96=$!
eltcalc -s < fifo/il_S1_eltcalc_P33 > work/kat/il_S1_eltcalc_P33 & pid97=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P33 > work/kat/il_S1_summarycalc_P33 & pid98=$!
pltcalc -H < fifo/il_S1_pltcalc_P33 > work/kat/il_S1_pltcalc_P33 & pid99=$!
eltcalc -s < fifo/il_S1_eltcalc_P34 > work/kat/il_S1_eltcalc_P34 & pid100=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P34 > work/kat/il_S1_summarycalc_P34 & pid101=$!
pltcalc -H < fifo/il_S1_pltcalc_P34 > work/kat/il_S1_pltcalc_P34 & pid102=$!
eltcalc -s < fifo/il_S1_eltcalc_P35 > work/kat/il_S1_eltcalc_P35 & pid103=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P35 > work/kat/il_S1_summarycalc_P35 & pid104=$!
pltcalc -H < fifo/il_S1_pltcalc_P35 > work/kat/il_S1_pltcalc_P35 & pid105=$!
eltcalc -s < fifo/il_S1_eltcalc_P36 > work/kat/il_S1_eltcalc_P36 & pid106=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P36 > work/kat/il_S1_summarycalc_P36 & pid107=$!
pltcalc -H < fifo/il_S1_pltcalc_P36 > work/kat/il_S1_pltcalc_P36 & pid108=$!
eltcalc -s < fifo/il_S1_eltcalc_P37 > work/kat/il_S1_eltcalc_P37 & pid109=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P37 > work/kat/il_S1_summarycalc_P37 & pid110=$!
pltcalc -H < fifo/il_S1_pltcalc_P37 > work/kat/il_S1_pltcalc_P37 & pid111=$!
eltcalc -s < fifo/il_S1_eltcalc_P38 > work/kat/il_S1_eltcalc_P38 & pid112=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P38 > work/kat/il_S1_summarycalc_P38 & pid113=$!
pltcalc -H < fifo/il_S1_pltcalc_P38 > work/kat/il_S1_pltcalc_P38 & pid114=$!
eltcalc -s < fifo/il_S1_eltcalc_P39 > work/kat/il_S1_eltcalc_P39 & pid115=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P39 > work/kat/il_S1_summarycalc_P39 & pid116=$!
pltcalc -H < fifo/il_S1_pltcalc_P39 > work/kat/il_S1_pltcalc_P39 & pid117=$!
eltcalc -s < fifo/il_S1_eltcalc_P40 > work/kat/il_S1_eltcalc_P40 & pid118=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P40 > work/kat/il_S1_summarycalc_P40 & pid119=$!
pltcalc -H < fifo/il_S1_pltcalc_P40 > work/kat/il_S1_pltcalc_P40 & pid120=$!


tee < fifo/il_S1_summary_P1 fifo/il_S1_eltcalc_P1 fifo/il_S1_summarycalc_P1 fifo/il_S1_pltcalc_P1 work/il_S1_summaryaalcalc/P1.bin work/il_S1_summaryleccalc/P1.bin > /dev/null & pid121=$!
tee < fifo/il_S1_summary_P1.idx work/il_S1_summaryaalcalc/P1.idx work/il_S1_summaryleccalc/P1.idx > /dev/null & pid122=$!
tee < fifo/il_S1_summary_P2 fifo/il_S1_eltcalc_P2 fifo/il_S1_summarycalc_P2 fifo/il_S1_pltcalc_P2 work/il_S1_summaryaalcalc/P2.bin work/il_S1_summaryleccalc/P2.bin > /dev/null & pid123=$!
tee < fifo/il_S1_summary_P2.idx work/il_S1_summaryaalcalc/P2.idx work/il_S1_summaryleccalc/P2.idx > /dev/null & pid124=$!
tee < fifo/il_S1_summary_P3 fifo/il_S1_eltcalc_P3 fifo/il_S1_summarycalc_P3 fifo/il_S1_pltcalc_P3 work/il_S1_summaryaalcalc/P3.bin work/il_S1_summaryleccalc/P3.bin > /dev/null & pid125=$!
tee < fifo/il_S1_summary_P3.idx work/il_S1_summaryaalcalc/P3.idx work/il_S1_summaryleccalc/P3.idx > /dev/null & pid126=$!
tee < fifo/il_S1_summary_P4 fifo/il_S1_eltcalc_P4 fifo/il_S1_summarycalc_P4 fifo/il_S1_pltcalc_P4 work/il_S1_summaryaalcalc/P4.bin work/il_S1_summaryleccalc/P4.bin > /dev/null & pid127=$!
tee < fifo/il_S1_summary_P4.idx work/il_S1_summaryaalcalc/P4.idx work/il_S1_summaryleccalc/P4.idx > /dev/null & pid128=$!
tee < fifo/il_S1_summary_P5 fifo/il_S1_eltcalc_P5 fifo/il_S1_summarycalc_P5 fifo/il_S1_pltcalc_P5 work/il_S1_summaryaalcalc/P5.bin work/il_S1_summaryleccalc/P5.bin > /dev/null & pid129=$!
tee < fifo/il_S1_summary_P5.idx work/il_S1_summaryaalcalc/P5.idx work/il_S1_summaryleccalc/P5.idx > /dev/null & pid130=$!
tee < fifo/il_S1_summary_P6 fifo/il_S1_eltcalc_P6 fifo/il_S1_summarycalc_P6 fifo/il_S1_pltcalc_P6 work/il_S1_summaryaalcalc/P6.bin work/il_S1_summaryleccalc/P6.bin > /dev/null & pid131=$!
tee < fifo/il_S1_summary_P6.idx work/il_S1_summaryaalcalc/P6.idx work/il_S1_summaryleccalc/P6.idx > /dev/null & pid132=$!
tee < fifo/il_S1_summary_P7 fifo/il_S1_eltcalc_P7 fifo/il_S1_summarycalc_P7 fifo/il_S1_pltcalc_P7 work/il_S1_summaryaalcalc/P7.bin work/il_S1_summaryleccalc/P7.bin > /dev/null & pid133=$!
tee < fifo/il_S1_summary_P7.idx work/il_S1_summaryaalcalc/P7.idx work/il_S1_summaryleccalc/P7.idx > /dev/null & pid134=$!
tee < fifo/il_S1_summary_P8 fifo/il_S1_eltcalc_P8 fifo/il_S1_summarycalc_P8 fifo/il_S1_pltcalc_P8 work/il_S1_summaryaalcalc/P8.bin work/il_S1_summaryleccalc/P8.bin > /dev/null & pid135=$!
tee < fifo/il_S1_summary_P8.idx work/il_S1_summaryaalcalc/P8.idx work/il_S1_summaryleccalc/P8.idx > /dev/null & pid136=$!
tee < fifo/il_S1_summary_P9 fifo/il_S1_eltcalc_P9 fifo/il_S1_summarycalc_P9 fifo/il_S1_pltcalc_P9 work/il_S1_summaryaalcalc/P9.bin work/il_S1_summaryleccalc/P9.bin > /dev/null & pid137=$!
tee < fifo/il_S1_summary_P9.idx work/il_S1_summaryaalcalc/P9.idx work/il_S1_summaryleccalc/P9.idx > /dev/null & pid138=$!
tee < fifo/il_S1_summary_P10 fifo/il_S1_eltcalc_P10 fifo/il_S1_summarycalc_P10 fifo/il_S1_pltcalc_P10 work/il_S1_summaryaalcalc/P10.bin work/il_S1_summaryleccalc/P10.bin > /dev/null & pid139=$!
tee < fifo/il_S1_summary_P10.idx work/il_S1_summaryaalcalc/P10.idx work/il_S1_summaryleccalc/P10.idx > /dev/null & pid140=$!
tee < fifo/il_S1_summary_P11 fifo/il_S1_eltcalc_P11 fifo/il_S1_summarycalc_P11 fifo/il_S1_pltcalc_P11 work/il_S1_summaryaalcalc/P11.bin work/il_S1_summaryleccalc/P11.bin > /dev/null & pid141=$!
tee < fifo/il_S1_summary_P11.idx work/il_S1_summaryaalcalc/P11.idx work/il_S1_summaryleccalc/P11.idx > /dev/null & pid142=$!
tee < fifo/il_S1_summary_P12 fifo/il_S1_eltcalc_P12 fifo/il_S1_summarycalc_P12 fifo/il_S1_pltcalc_P12 work/il_S1_summaryaalcalc/P12.bin work/il_S1_summaryleccalc/P12.bin > /dev/null & pid143=$!
tee < fifo/il_S1_summary_P12.idx work/il_S1_summaryaalcalc/P12.idx work/il_S1_summaryleccalc/P12.idx > /dev/null & pid144=$!
tee < fifo/il_S1_summary_P13 fifo/il_S1_eltcalc_P13 fifo/il_S1_summarycalc_P13 fifo/il_S1_pltcalc_P13 work/il_S1_summaryaalcalc/P13.bin work/il_S1_summaryleccalc/P13.bin > /dev/null & pid145=$!
tee < fifo/il_S1_summary_P13.idx work/il_S1_summaryaalcalc/P13.idx work/il_S1_summaryleccalc/P13.idx > /dev/null & pid146=$!
tee < fifo/il_S1_summary_P14 fifo/il_S1_eltcalc_P14 fifo/il_S1_summarycalc_P14 fifo/il_S1_pltcalc_P14 work/il_S1_summaryaalcalc/P14.bin work/il_S1_summaryleccalc/P14.bin > /dev/null & pid147=$!
tee < fifo/il_S1_summary_P14.idx work/il_S1_summaryaalcalc/P14.idx work/il_S1_summaryleccalc/P14.idx > /dev/null & pid148=$!
tee < fifo/il_S1_summary_P15 fifo/il_S1_eltcalc_P15 fifo/il_S1_summarycalc_P15 fifo/il_S1_pltcalc_P15 work/il_S1_summaryaalcalc/P15.bin work/il_S1_summaryleccalc/P15.bin > /dev/null & pid149=$!
tee < fifo/il_S1_summary_P15.idx work/il_S1_summaryaalcalc/P15.idx work/il_S1_summaryleccalc/P15.idx > /dev/null & pid150=$!
tee < fifo/il_S1_summary_P16 fifo/il_S1_eltcalc_P16 fifo/il_S1_summarycalc_P16 fifo/il_S1_pltcalc_P16 work/il_S1_summaryaalcalc/P16.bin work/il_S1_summaryleccalc/P16.bin > /dev/null & pid151=$!
tee < fifo/il_S1_summary_P16.idx work/il_S1_summaryaalcalc/P16.idx work/il_S1_summaryleccalc/P16.idx > /dev/null & pid152=$!
tee < fifo/il_S1_summary_P17 fifo/il_S1_eltcalc_P17 fifo/il_S1_summarycalc_P17 fifo/il_S1_pltcalc_P17 work/il_S1_summaryaalcalc/P17.bin work/il_S1_summaryleccalc/P17.bin > /dev/null & pid153=$!
tee < fifo/il_S1_summary_P17.idx work/il_S1_summaryaalcalc/P17.idx work/il_S1_summaryleccalc/P17.idx > /dev/null & pid154=$!
tee < fifo/il_S1_summary_P18 fifo/il_S1_eltcalc_P18 fifo/il_S1_summarycalc_P18 fifo/il_S1_pltcalc_P18 work/il_S1_summaryaalcalc/P18.bin work/il_S1_summaryleccalc/P18.bin > /dev/null & pid155=$!
tee < fifo/il_S1_summary_P18.idx work/il_S1_summaryaalcalc/P18.idx work/il_S1_summaryleccalc/P18.idx > /dev/null & pid156=$!
tee < fifo/il_S1_summary_P19 fifo/il_S1_eltcalc_P19 fifo/il_S1_summarycalc_P19 fifo/il_S1_pltcalc_P19 work/il_S1_summaryaalcalc/P19.bin work/il_S1_summaryleccalc/P19.bin > /dev/null & pid157=$!
tee < fifo/il_S1_summary_P19.idx work/il_S1_summaryaalcalc/P19.idx work/il_S1_summaryleccalc/P19.idx > /dev/null & pid158=$!
tee < fifo/il_S1_summary_P20 fifo/il_S1_eltcalc_P20 fifo/il_S1_summarycalc_P20 fifo/il_S1_pltcalc_P20 work/il_S1_summaryaalcalc/P20.bin work/il_S1_summaryleccalc/P20.bin > /dev/null & pid159=$!
tee < fifo/il_S1_summary_P20.idx work/il_S1_summaryaalcalc/P20.idx work/il_S1_summaryleccalc/P20.idx > /dev/null & pid160=$!
tee < fifo/il_S1_summary_P21 fifo/il_S1_eltcalc_P21 fifo/il_S1_summarycalc_P21 fifo/il_S1_pltcalc_P21 work/il_S1_summaryaalcalc/P21.bin work/il_S1_summaryleccalc/P21.bin > /dev/null & pid161=$!
tee < fifo/il_S1_summary_P21.idx work/il_S1_summaryaalcalc/P21.idx work/il_S1_summaryleccalc/P21.idx > /dev/null & pid162=$!
tee < fifo/il_S1_summary_P22 fifo/il_S1_eltcalc_P22 fifo/il_S1_summarycalc_P22 fifo/il_S1_pltcalc_P22 work/il_S1_summaryaalcalc/P22.bin work/il_S1_summaryleccalc/P22.bin > /dev/null & pid163=$!
tee < fifo/il_S1_summary_P22.idx work/il_S1_summaryaalcalc/P22.idx work/il_S1_summaryleccalc/P22.idx > /dev/null & pid164=$!
tee < fifo/il_S1_summary_P23 fifo/il_S1_eltcalc_P23 fifo/il_S1_summarycalc_P23 fifo/il_S1_pltcalc_P23 work/il_S1_summaryaalcalc/P23.bin work/il_S1_summaryleccalc/P23.bin > /dev/null & pid165=$!
tee < fifo/il_S1_summary_P23.idx work/il_S1_summaryaalcalc/P23.idx work/il_S1_summaryleccalc/P23.idx > /dev/null & pid166=$!
tee < fifo/il_S1_summary_P24 fifo/il_S1_eltcalc_P24 fifo/il_S1_summarycalc_P24 fifo/il_S1_pltcalc_P24 work/il_S1_summaryaalcalc/P24.bin work/il_S1_summaryleccalc/P24.bin > /dev/null & pid167=$!
tee < fifo/il_S1_summary_P24.idx work/il_S1_summaryaalcalc/P24.idx work/il_S1_summaryleccalc/P24.idx > /dev/null & pid168=$!
tee < fifo/il_S1_summary_P25 fifo/il_S1_eltcalc_P25 fifo/il_S1_summarycalc_P25 fifo/il_S1_pltcalc_P25 work/il_S1_summaryaalcalc/P25.bin work/il_S1_summaryleccalc/P25.bin > /dev/null & pid169=$!
tee < fifo/il_S1_summary_P25.idx work/il_S1_summaryaalcalc/P25.idx work/il_S1_summaryleccalc/P25.idx > /dev/null & pid170=$!
tee < fifo/il_S1_summary_P26 fifo/il_S1_eltcalc_P26 fifo/il_S1_summarycalc_P26 fifo/il_S1_pltcalc_P26 work/il_S1_summaryaalcalc/P26.bin work/il_S1_summaryleccalc/P26.bin > /dev/null & pid171=$!
tee < fifo/il_S1_summary_P26.idx work/il_S1_summaryaalcalc/P26.idx work/il_S1_summaryleccalc/P26.idx > /dev/null & pid172=$!
tee < fifo/il_S1_summary_P27 fifo/il_S1_eltcalc_P27 fifo/il_S1_summarycalc_P27 fifo/il_S1_pltcalc_P27 work/il_S1_summaryaalcalc/P27.bin work/il_S1_summaryleccalc/P27.bin > /dev/null & pid173=$!
tee < fifo/il_S1_summary_P27.idx work/il_S1_summaryaalcalc/P27.idx work/il_S1_summaryleccalc/P27.idx > /dev/null & pid174=$!
tee < fifo/il_S1_summary_P28 fifo/il_S1_eltcalc_P28 fifo/il_S1_summarycalc_P28 fifo/il_S1_pltcalc_P28 work/il_S1_summaryaalcalc/P28.bin work/il_S1_summaryleccalc/P28.bin > /dev/null & pid175=$!
tee < fifo/il_S1_summary_P28.idx work/il_S1_summaryaalcalc/P28.idx work/il_S1_summaryleccalc/P28.idx > /dev/null & pid176=$!
tee < fifo/il_S1_summary_P29 fifo/il_S1_eltcalc_P29 fifo/il_S1_summarycalc_P29 fifo/il_S1_pltcalc_P29 work/il_S1_summaryaalcalc/P29.bin work/il_S1_summaryleccalc/P29.bin > /dev/null & pid177=$!
tee < fifo/il_S1_summary_P29.idx work/il_S1_summaryaalcalc/P29.idx work/il_S1_summaryleccalc/P29.idx > /dev/null & pid178=$!
tee < fifo/il_S1_summary_P30 fifo/il_S1_eltcalc_P30 fifo/il_S1_summarycalc_P30 fifo/il_S1_pltcalc_P30 work/il_S1_summaryaalcalc/P30.bin work/il_S1_summaryleccalc/P30.bin > /dev/null & pid179=$!
tee < fifo/il_S1_summary_P30.idx work/il_S1_summaryaalcalc/P30.idx work/il_S1_summaryleccalc/P30.idx > /dev/null & pid180=$!
tee < fifo/il_S1_summary_P31 fifo/il_S1_eltcalc_P31 fifo/il_S1_summarycalc_P31 fifo/il_S1_pltcalc_P31 work/il_S1_summaryaalcalc/P31.bin work/il_S1_summaryleccalc/P31.bin > /dev/null & pid181=$!
tee < fifo/il_S1_summary_P31.idx work/il_S1_summaryaalcalc/P31.idx work/il_S1_summaryleccalc/P31.idx > /dev/null & pid182=$!
tee < fifo/il_S1_summary_P32 fifo/il_S1_eltcalc_P32 fifo/il_S1_summarycalc_P32 fifo/il_S1_pltcalc_P32 work/il_S1_summaryaalcalc/P32.bin work/il_S1_summaryleccalc/P32.bin > /dev/null & pid183=$!
tee < fifo/il_S1_summary_P32.idx work/il_S1_summaryaalcalc/P32.idx work/il_S1_summaryleccalc/P32.idx > /dev/null & pid184=$!
tee < fifo/il_S1_summary_P33 fifo/il_S1_eltcalc_P33 fifo/il_S1_summarycalc_P33 fifo/il_S1_pltcalc_P33 work/il_S1_summaryaalcalc/P33.bin work/il_S1_summaryleccalc/P33.bin > /dev/null & pid185=$!
tee < fifo/il_S1_summary_P33.idx work/il_S1_summaryaalcalc/P33.idx work/il_S1_summaryleccalc/P33.idx > /dev/null & pid186=$!
tee < fifo/il_S1_summary_P34 fifo/il_S1_eltcalc_P34 fifo/il_S1_summarycalc_P34 fifo/il_S1_pltcalc_P34 work/il_S1_summaryaalcalc/P34.bin work/il_S1_summaryleccalc/P34.bin > /dev/null & pid187=$!
tee < fifo/il_S1_summary_P34.idx work/il_S1_summaryaalcalc/P34.idx work/il_S1_summaryleccalc/P34.idx > /dev/null & pid188=$!
tee < fifo/il_S1_summary_P35 fifo/il_S1_eltcalc_P35 fifo/il_S1_summarycalc_P35 fifo/il_S1_pltcalc_P35 work/il_S1_summaryaalcalc/P35.bin work/il_S1_summaryleccalc/P35.bin > /dev/null & pid189=$!
tee < fifo/il_S1_summary_P35.idx work/il_S1_summaryaalcalc/P35.idx work/il_S1_summaryleccalc/P35.idx > /dev/null & pid190=$!
tee < fifo/il_S1_summary_P36 fifo/il_S1_eltcalc_P36 fifo/il_S1_summarycalc_P36 fifo/il_S1_pltcalc_P36 work/il_S1_summaryaalcalc/P36.bin work/il_S1_summaryleccalc/P36.bin > /dev/null & pid191=$!
tee < fifo/il_S1_summary_P36.idx work/il_S1_summaryaalcalc/P36.idx work/il_S1_summaryleccalc/P36.idx > /dev/null & pid192=$!
tee < fifo/il_S1_summary_P37 fifo/il_S1_eltcalc_P37 fifo/il_S1_summarycalc_P37 fifo/il_S1_pltcalc_P37 work/il_S1_summaryaalcalc/P37.bin work/il_S1_summaryleccalc/P37.bin > /dev/null & pid193=$!
tee < fifo/il_S1_summary_P37.idx work/il_S1_summaryaalcalc/P37.idx work/il_S1_summaryleccalc/P37.idx > /dev/null & pid194=$!
tee < fifo/il_S1_summary_P38 fifo/il_S1_eltcalc_P38 fifo/il_S1_summarycalc_P38 fifo/il_S1_pltcalc_P38 work/il_S1_summaryaalcalc/P38.bin work/il_S1_summaryleccalc/P38.bin > /dev/null & pid195=$!
tee < fifo/il_S1_summary_P38.idx work/il_S1_summaryaalcalc/P38.idx work/il_S1_summaryleccalc/P38.idx > /dev/null & pid196=$!
tee < fifo/il_S1_summary_P39 fifo/il_S1_eltcalc_P39 fifo/il_S1_summarycalc_P39 fifo/il_S1_pltcalc_P39 work/il_S1_summaryaalcalc/P39.bin work/il_S1_summaryleccalc/P39.bin > /dev/null & pid197=$!
tee < fifo/il_S1_summary_P39.idx work/il_S1_summaryaalcalc/P39.idx work/il_S1_summaryleccalc/P39.idx > /dev/null & pid198=$!
tee < fifo/il_S1_summary_P40 fifo/il_S1_eltcalc_P40 fifo/il_S1_summarycalc_P40 fifo/il_S1_pltcalc_P40 work/il_S1_summaryaalcalc/P40.bin work/il_S1_summaryleccalc/P40.bin > /dev/null & pid199=$!
tee < fifo/il_S1_summary_P40.idx work/il_S1_summaryaalcalc/P40.idx work/il_S1_summaryleccalc/P40.idx > /dev/null & pid200=$!

summarycalc -m -f  -1 fifo/il_S1_summary_P1 < fifo/il_P1 &
summarycalc -m -f  -1 fifo/il_S1_summary_P2 < fifo/il_P2 &
summarycalc -m -f  -1 fifo/il_S1_summary_P3 < fifo/il_P3 &
summarycalc -m -f  -1 fifo/il_S1_summary_P4 < fifo/il_P4 &
summarycalc -m -f  -1 fifo/il_S1_summary_P5 < fifo/il_P5 &
summarycalc -m -f  -1 fifo/il_S1_summary_P6 < fifo/il_P6 &
summarycalc -m -f  -1 fifo/il_S1_summary_P7 < fifo/il_P7 &
summarycalc -m -f  -1 fifo/il_S1_summary_P8 < fifo/il_P8 &
summarycalc -m -f  -1 fifo/il_S1_summary_P9 < fifo/il_P9 &
summarycalc -m -f  -1 fifo/il_S1_summary_P10 < fifo/il_P10 &
summarycalc -m -f  -1 fifo/il_S1_summary_P11 < fifo/il_P11 &
summarycalc -m -f  -1 fifo/il_S1_summary_P12 < fifo/il_P12 &
summarycalc -m -f  -1 fifo/il_S1_summary_P13 < fifo/il_P13 &
summarycalc -m -f  -1 fifo/il_S1_summary_P14 < fifo/il_P14 &
summarycalc -m -f  -1 fifo/il_S1_summary_P15 < fifo/il_P15 &
summarycalc -m -f  -1 fifo/il_S1_summary_P16 < fifo/il_P16 &
summarycalc -m -f  -1 fifo/il_S1_summary_P17 < fifo/il_P17 &
summarycalc -m -f  -1 fifo/il_S1_summary_P18 < fifo/il_P18 &
summarycalc -m -f  -1 fifo/il_S1_summary_P19 < fifo/il_P19 &
summarycalc -m -f  -1 fifo/il_S1_summary_P20 < fifo/il_P20 &
summarycalc -m -f  -1 fifo/il_S1_summary_P21 < fifo/il_P21 &
summarycalc -m -f  -1 fifo/il_S1_summary_P22 < fifo/il_P22 &
summarycalc -m -f  -1 fifo/il_S1_summary_P23 < fifo/il_P23 &
summarycalc -m -f  -1 fifo/il_S1_summary_P24 < fifo/il_P24 &
summarycalc -m -f  -1 fifo/il_S1_summary_P25 < fifo/il_P25 &
summarycalc -m -f  -1 fifo/il_S1_summary_P26 < fifo/il_P26 &
summarycalc -m -f  -1 fifo/il_S1_summary_P27 < fifo/il_P27 &
summarycalc -m -f  -1 fifo/il_S1_summary_P28 < fifo/il_P28 &
summarycalc -m -f  -1 fifo/il_S1_summary_P29 < fifo/il_P29 &
summarycalc -m -f  -1 fifo/il_S1_summary_P30 < fifo/il_P30 &
summarycalc -m -f  -1 fifo/il_S1_summary_P31 < fifo/il_P31 &
summarycalc -m -f  -1 fifo/il_S1_summary_P32 < fifo/il_P32 &
summarycalc -m -f  -1 fifo/il_S1_summary_P33 < fifo/il_P33 &
summarycalc -m -f  -1 fifo/il_S1_summary_P34 < fifo/il_P34 &
summarycalc -m -f  -1 fifo/il_S1_summary_P35 < fifo/il_P35 &
summarycalc -m -f  -1 fifo/il_S1_summary_P36 < fifo/il_P36 &
summarycalc -m -f  -1 fifo/il_S1_summary_P37 < fifo/il_P37 &
summarycalc -m -f  -1 fifo/il_S1_summary_P38 < fifo/il_P38 &
summarycalc -m -f  -1 fifo/il_S1_summary_P39 < fifo/il_P39 &
summarycalc -m -f  -1 fifo/il_S1_summary_P40 < fifo/il_P40 &

# --- Do ground up loss computes ---

eltcalc < fifo/gul_S1_eltcalc_P1 > work/kat/gul_S1_eltcalc_P1 & pid201=$!
summarycalctocsv < fifo/gul_S1_summarycalc_P1 > work/kat/gul_S1_summarycalc_P1 & pid202=$!
pltcalc < fifo/gul_S1_pltcalc_P1 > work/kat/gul_S1_pltcalc_P1 & pid203=$!
eltcalc -s < fifo/gul_S1_eltcalc_P2 > work/kat/gul_S1_eltcalc_P2 & pid204=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P2 > work/kat/gul_S1_summarycalc_P2 & pid205=$!
pltcalc -H < fifo/gul_S1_pltcalc_P2 > work/kat/gul_S1_pltcalc_P2 & pid206=$!
eltcalc -s < fifo/gul_S1_eltcalc_P3 > work/kat/gul_S1_eltcalc_P3 & pid207=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P3 > work/kat/gul_S1_summarycalc_P3 & pid208=$!
pltcalc -H < fifo/gul_S1_pltcalc_P3 > work/kat/gul_S1_pltcalc_P3 & pid209=$!
eltcalc -s < fifo/gul_S1_eltcalc_P4 > work/kat/gul_S1_eltcalc_P4 & pid210=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P4 > work/kat/gul_S1_summarycalc_P4 & pid211=$!
pltcalc -H < fifo/gul_S1_pltcalc_P4 > work/kat/gul_S1_pltcalc_P4 & pid212=$!
eltcalc -s < fifo/gul_S1_eltcalc_P5 > work/kat/gul_S1_eltcalc_P5 & pid213=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P5 > work/kat/gul_S1_summarycalc_P5 & pid214=$!
pltcalc -H < fifo/gul_S1_pltcalc_P5 > work/kat/gul_S1_pltcalc_P5 & pid215=$!
eltcalc -s < fifo/gul_S1_eltcalc_P6 > work/kat/gul_S1_eltcalc_P6 & pid216=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P6 > work/kat/gul_S1_summarycalc_P6 & pid217=$!
pltcalc -H < fifo/gul_S1_pltcalc_P6 > work/kat/gul_S1_pltcalc_P6 & pid218=$!
eltcalc -s < fifo/gul_S1_eltcalc_P7 > work/kat/gul_S1_eltcalc_P7 & pid219=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P7 > work/kat/gul_S1_summarycalc_P7 & pid220=$!
pltcalc -H < fifo/gul_S1_pltcalc_P7 > work/kat/gul_S1_pltcalc_P7 & pid221=$!
eltcalc -s < fifo/gul_S1_eltcalc_P8 > work/kat/gul_S1_eltcalc_P8 & pid222=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P8 > work/kat/gul_S1_summarycalc_P8 & pid223=$!
pltcalc -H < fifo/gul_S1_pltcalc_P8 > work/kat/gul_S1_pltcalc_P8 & pid224=$!
eltcalc -s < fifo/gul_S1_eltcalc_P9 > work/kat/gul_S1_eltcalc_P9 & pid225=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P9 > work/kat/gul_S1_summarycalc_P9 & pid226=$!
pltcalc -H < fifo/gul_S1_pltcalc_P9 > work/kat/gul_S1_pltcalc_P9 & pid227=$!
eltcalc -s < fifo/gul_S1_eltcalc_P10 > work/kat/gul_S1_eltcalc_P10 & pid228=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P10 > work/kat/gul_S1_summarycalc_P10 & pid229=$!
pltcalc -H < fifo/gul_S1_pltcalc_P10 > work/kat/gul_S1_pltcalc_P10 & pid230=$!
eltcalc -s < fifo/gul_S1_eltcalc_P11 > work/kat/gul_S1_eltcalc_P11 & pid231=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P11 > work/kat/gul_S1_summarycalc_P11 & pid232=$!
pltcalc -H < fifo/gul_S1_pltcalc_P11 > work/kat/gul_S1_pltcalc_P11 & pid233=$!
eltcalc -s < fifo/gul_S1_eltcalc_P12 > work/kat/gul_S1_eltcalc_P12 & pid234=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P12 > work/kat/gul_S1_summarycalc_P12 & pid235=$!
pltcalc -H < fifo/gul_S1_pltcalc_P12 > work/kat/gul_S1_pltcalc_P12 & pid236=$!
eltcalc -s < fifo/gul_S1_eltcalc_P13 > work/kat/gul_S1_eltcalc_P13 & pid237=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P13 > work/kat/gul_S1_summarycalc_P13 & pid238=$!
pltcalc -H < fifo/gul_S1_pltcalc_P13 > work/kat/gul_S1_pltcalc_P13 & pid239=$!
eltcalc -s < fifo/gul_S1_eltcalc_P14 > work/kat/gul_S1_eltcalc_P14 & pid240=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P14 > work/kat/gul_S1_summarycalc_P14 & pid241=$!
pltcalc -H < fifo/gul_S1_pltcalc_P14 > work/kat/gul_S1_pltcalc_P14 & pid242=$!
eltcalc -s < fifo/gul_S1_eltcalc_P15 > work/kat/gul_S1_eltcalc_P15 & pid243=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P15 > work/kat/gul_S1_summarycalc_P15 & pid244=$!
pltcalc -H < fifo/gul_S1_pltcalc_P15 > work/kat/gul_S1_pltcalc_P15 & pid245=$!
eltcalc -s < fifo/gul_S1_eltcalc_P16 > work/kat/gul_S1_eltcalc_P16 & pid246=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P16 > work/kat/gul_S1_summarycalc_P16 & pid247=$!
pltcalc -H < fifo/gul_S1_pltcalc_P16 > work/kat/gul_S1_pltcalc_P16 & pid248=$!
eltcalc -s < fifo/gul_S1_eltcalc_P17 > work/kat/gul_S1_eltcalc_P17 & pid249=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P17 > work/kat/gul_S1_summarycalc_P17 & pid250=$!
pltcalc -H < fifo/gul_S1_pltcalc_P17 > work/kat/gul_S1_pltcalc_P17 & pid251=$!
eltcalc -s < fifo/gul_S1_eltcalc_P18 > work/kat/gul_S1_eltcalc_P18 & pid252=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P18 > work/kat/gul_S1_summarycalc_P18 & pid253=$!
pltcalc -H < fifo/gul_S1_pltcalc_P18 > work/kat/gul_S1_pltcalc_P18 & pid254=$!
eltcalc -s < fifo/gul_S1_eltcalc_P19 > work/kat/gul_S1_eltcalc_P19 & pid255=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P19 > work/kat/gul_S1_summarycalc_P19 & pid256=$!
pltcalc -H < fifo/gul_S1_pltcalc_P19 > work/kat/gul_S1_pltcalc_P19 & pid257=$!
eltcalc -s < fifo/gul_S1_eltcalc_P20 > work/kat/gul_S1_eltcalc_P20 & pid258=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P20 > work/kat/gul_S1_summarycalc_P20 & pid259=$!
pltcalc -H < fifo/gul_S1_pltcalc_P20 > work/kat/gul_S1_pltcalc_P20 & pid260=$!
eltcalc -s < fifo/gul_S1_eltcalc_P21 > work/kat/gul_S1_eltcalc_P21 & pid261=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P21 > work/kat/gul_S1_summarycalc_P21 & pid262=$!
pltcalc -H < fifo/gul_S1_pltcalc_P21 > work/kat/gul_S1_pltcalc_P21 & pid263=$!
eltcalc -s < fifo/gul_S1_eltcalc_P22 > work/kat/gul_S1_eltcalc_P22 & pid264=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P22 > work/kat/gul_S1_summarycalc_P22 & pid265=$!
pltcalc -H < fifo/gul_S1_pltcalc_P22 > work/kat/gul_S1_pltcalc_P22 & pid266=$!
eltcalc -s < fifo/gul_S1_eltcalc_P23 > work/kat/gul_S1_eltcalc_P23 & pid267=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P23 > work/kat/gul_S1_summarycalc_P23 & pid268=$!
pltcalc -H < fifo/gul_S1_pltcalc_P23 > work/kat/gul_S1_pltcalc_P23 & pid269=$!
eltcalc -s < fifo/gul_S1_eltcalc_P24 > work/kat/gul_S1_eltcalc_P24 & pid270=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P24 > work/kat/gul_S1_summarycalc_P24 & pid271=$!
pltcalc -H < fifo/gul_S1_pltcalc_P24 > work/kat/gul_S1_pltcalc_P24 & pid272=$!
eltcalc -s < fifo/gul_S1_eltcalc_P25 > work/kat/gul_S1_eltcalc_P25 & pid273=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P25 > work/kat/gul_S1_summarycalc_P25 & pid274=$!
pltcalc -H < fifo/gul_S1_pltcalc_P25 > work/kat/gul_S1_pltcalc_P25 & pid275=$!
eltcalc -s < fifo/gul_S1_eltcalc_P26 > work/kat/gul_S1_eltcalc_P26 & pid276=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P26 > work/kat/gul_S1_summarycalc_P26 & pid277=$!
pltcalc -H < fifo/gul_S1_pltcalc_P26 > work/kat/gul_S1_pltcalc_P26 & pid278=$!
eltcalc -s < fifo/gul_S1_eltcalc_P27 > work/kat/gul_S1_eltcalc_P27 & pid279=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P27 > work/kat/gul_S1_summarycalc_P27 & pid280=$!
pltcalc -H < fifo/gul_S1_pltcalc_P27 > work/kat/gul_S1_pltcalc_P27 & pid281=$!
eltcalc -s < fifo/gul_S1_eltcalc_P28 > work/kat/gul_S1_eltcalc_P28 & pid282=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P28 > work/kat/gul_S1_summarycalc_P28 & pid283=$!
pltcalc -H < fifo/gul_S1_pltcalc_P28 > work/kat/gul_S1_pltcalc_P28 & pid284=$!
eltcalc -s < fifo/gul_S1_eltcalc_P29 > work/kat/gul_S1_eltcalc_P29 & pid285=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P29 > work/kat/gul_S1_summarycalc_P29 & pid286=$!
pltcalc -H < fifo/gul_S1_pltcalc_P29 > work/kat/gul_S1_pltcalc_P29 & pid287=$!
eltcalc -s < fifo/gul_S1_eltcalc_P30 > work/kat/gul_S1_eltcalc_P30 & pid288=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P30 > work/kat/gul_S1_summarycalc_P30 & pid289=$!
pltcalc -H < fifo/gul_S1_pltcalc_P30 > work/kat/gul_S1_pltcalc_P30 & pid290=$!
eltcalc -s < fifo/gul_S1_eltcalc_P31 > work/kat/gul_S1_eltcalc_P31 & pid291=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P31 > work/kat/gul_S1_summarycalc_P31 & pid292=$!
pltcalc -H < fifo/gul_S1_pltcalc_P31 > work/kat/gul_S1_pltcalc_P31 & pid293=$!
eltcalc -s < fifo/gul_S1_eltcalc_P32 > work/kat/gul_S1_eltcalc_P32 & pid294=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P32 > work/kat/gul_S1_summarycalc_P32 & pid295=$!
pltcalc -H < fifo/gul_S1_pltcalc_P32 > work/kat/gul_S1_pltcalc_P32 & pid296=$!
eltcalc -s < fifo/gul_S1_eltcalc_P33 > work/kat/gul_S1_eltcalc_P33 & pid297=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P33 > work/kat/gul_S1_summarycalc_P33 & pid298=$!
pltcalc -H < fifo/gul_S1_pltcalc_P33 > work/kat/gul_S1_pltcalc_P33 & pid299=$!
eltcalc -s < fifo/gul_S1_eltcalc_P34 > work/kat/gul_S1_eltcalc_P34 & pid300=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P34 > work/kat/gul_S1_summarycalc_P34 & pid301=$!
pltcalc -H < fifo/gul_S1_pltcalc_P34 > work/kat/gul_S1_pltcalc_P34 & pid302=$!
eltcalc -s < fifo/gul_S1_eltcalc_P35 > work/kat/gul_S1_eltcalc_P35 & pid303=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P35 > work/kat/gul_S1_summarycalc_P35 & pid304=$!
pltcalc -H < fifo/gul_S1_pltcalc_P35 > work/kat/gul_S1_pltcalc_P35 & pid305=$!
eltcalc -s < fifo/gul_S1_eltcalc_P36 > work/kat/gul_S1_eltcalc_P36 & pid306=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P36 > work/kat/gul_S1_summarycalc_P36 & pid307=$!
pltcalc -H < fifo/gul_S1_pltcalc_P36 > work/kat/gul_S1_pltcalc_P36 & pid308=$!
eltcalc -s < fifo/gul_S1_eltcalc_P37 > work/kat/gul_S1_eltcalc_P37 & pid309=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P37 > work/kat/gul_S1_summarycalc_P37 & pid310=$!
pltcalc -H < fifo/gul_S1_pltcalc_P37 > work/kat/gul_S1_pltcalc_P37 & pid311=$!
eltcalc -s < fifo/gul_S1_eltcalc_P38 > work/kat/gul_S1_eltcalc_P38 & pid312=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P38 > work/kat/gul_S1_summarycalc_P38 & pid313=$!
pltcalc -H < fifo/gul_S1_pltcalc_P38 > work/kat/gul_S1_pltcalc_P38 & pid314=$!
eltcalc -s < fifo/gul_S1_eltcalc_P39 > work/kat/gul_S1_eltcalc_P39 & pid315=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P39 > work/kat/gul_S1_summarycalc_P39 & pid316=$!
pltcalc -H < fifo/gul_S1_pltcalc_P39 > work/kat/gul_S1_pltcalc_P39 & pid317=$!
eltcalc -s < fifo/gul_S1_eltcalc_P40 > work/kat/gul_S1_eltcalc_P40 & pid318=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P40 > work/kat/gul_S1_summarycalc_P40 & pid319=$!
pltcalc -H < fifo/gul_S1_pltcalc_P40 > work/kat/gul_S1_pltcalc_P40 & pid320=$!


tee < fifo/gul_S1_summary_P1 fifo/gul_S1_eltcalc_P1 fifo/gul_S1_summarycalc_P1 fifo/gul_S1_pltcalc_P1 work/gul_S1_summaryaalcalc/P1.bin work/gul_S1_summaryleccalc/P1.bin > /dev/null & pid321=$!
tee < fifo/gul_S1_summary_P1.idx work/gul_S1_summaryaalcalc/P1.idx work/gul_S1_summaryleccalc/P1.idx > /dev/null & pid322=$!
tee < fifo/gul_S1_summary_P2 fifo/gul_S1_eltcalc_P2 fifo/gul_S1_summarycalc_P2 fifo/gul_S1_pltcalc_P2 work/gul_S1_summaryaalcalc/P2.bin work/gul_S1_summaryleccalc/P2.bin > /dev/null & pid323=$!
tee < fifo/gul_S1_summary_P2.idx work/gul_S1_summaryaalcalc/P2.idx work/gul_S1_summaryleccalc/P2.idx > /dev/null & pid324=$!
tee < fifo/gul_S1_summary_P3 fifo/gul_S1_eltcalc_P3 fifo/gul_S1_summarycalc_P3 fifo/gul_S1_pltcalc_P3 work/gul_S1_summaryaalcalc/P3.bin work/gul_S1_summaryleccalc/P3.bin > /dev/null & pid325=$!
tee < fifo/gul_S1_summary_P3.idx work/gul_S1_summaryaalcalc/P3.idx work/gul_S1_summaryleccalc/P3.idx > /dev/null & pid326=$!
tee < fifo/gul_S1_summary_P4 fifo/gul_S1_eltcalc_P4 fifo/gul_S1_summarycalc_P4 fifo/gul_S1_pltcalc_P4 work/gul_S1_summaryaalcalc/P4.bin work/gul_S1_summaryleccalc/P4.bin > /dev/null & pid327=$!
tee < fifo/gul_S1_summary_P4.idx work/gul_S1_summaryaalcalc/P4.idx work/gul_S1_summaryleccalc/P4.idx > /dev/null & pid328=$!
tee < fifo/gul_S1_summary_P5 fifo/gul_S1_eltcalc_P5 fifo/gul_S1_summarycalc_P5 fifo/gul_S1_pltcalc_P5 work/gul_S1_summaryaalcalc/P5.bin work/gul_S1_summaryleccalc/P5.bin > /dev/null & pid329=$!
tee < fifo/gul_S1_summary_P5.idx work/gul_S1_summaryaalcalc/P5.idx work/gul_S1_summaryleccalc/P5.idx > /dev/null & pid330=$!
tee < fifo/gul_S1_summary_P6 fifo/gul_S1_eltcalc_P6 fifo/gul_S1_summarycalc_P6 fifo/gul_S1_pltcalc_P6 work/gul_S1_summaryaalcalc/P6.bin work/gul_S1_summaryleccalc/P6.bin > /dev/null & pid331=$!
tee < fifo/gul_S1_summary_P6.idx work/gul_S1_summaryaalcalc/P6.idx work/gul_S1_summaryleccalc/P6.idx > /dev/null & pid332=$!
tee < fifo/gul_S1_summary_P7 fifo/gul_S1_eltcalc_P7 fifo/gul_S1_summarycalc_P7 fifo/gul_S1_pltcalc_P7 work/gul_S1_summaryaalcalc/P7.bin work/gul_S1_summaryleccalc/P7.bin > /dev/null & pid333=$!
tee < fifo/gul_S1_summary_P7.idx work/gul_S1_summaryaalcalc/P7.idx work/gul_S1_summaryleccalc/P7.idx > /dev/null & pid334=$!
tee < fifo/gul_S1_summary_P8 fifo/gul_S1_eltcalc_P8 fifo/gul_S1_summarycalc_P8 fifo/gul_S1_pltcalc_P8 work/gul_S1_summaryaalcalc/P8.bin work/gul_S1_summaryleccalc/P8.bin > /dev/null & pid335=$!
tee < fifo/gul_S1_summary_P8.idx work/gul_S1_summaryaalcalc/P8.idx work/gul_S1_summaryleccalc/P8.idx > /dev/null & pid336=$!
tee < fifo/gul_S1_summary_P9 fifo/gul_S1_eltcalc_P9 fifo/gul_S1_summarycalc_P9 fifo/gul_S1_pltcalc_P9 work/gul_S1_summaryaalcalc/P9.bin work/gul_S1_summaryleccalc/P9.bin > /dev/null & pid337=$!
tee < fifo/gul_S1_summary_P9.idx work/gul_S1_summaryaalcalc/P9.idx work/gul_S1_summaryleccalc/P9.idx > /dev/null & pid338=$!
tee < fifo/gul_S1_summary_P10 fifo/gul_S1_eltcalc_P10 fifo/gul_S1_summarycalc_P10 fifo/gul_S1_pltcalc_P10 work/gul_S1_summaryaalcalc/P10.bin work/gul_S1_summaryleccalc/P10.bin > /dev/null & pid339=$!
tee < fifo/gul_S1_summary_P10.idx work/gul_S1_summaryaalcalc/P10.idx work/gul_S1_summaryleccalc/P10.idx > /dev/null & pid340=$!
tee < fifo/gul_S1_summary_P11 fifo/gul_S1_eltcalc_P11 fifo/gul_S1_summarycalc_P11 fifo/gul_S1_pltcalc_P11 work/gul_S1_summaryaalcalc/P11.bin work/gul_S1_summaryleccalc/P11.bin > /dev/null & pid341=$!
tee < fifo/gul_S1_summary_P11.idx work/gul_S1_summaryaalcalc/P11.idx work/gul_S1_summaryleccalc/P11.idx > /dev/null & pid342=$!
tee < fifo/gul_S1_summary_P12 fifo/gul_S1_eltcalc_P12 fifo/gul_S1_summarycalc_P12 fifo/gul_S1_pltcalc_P12 work/gul_S1_summaryaalcalc/P12.bin work/gul_S1_summaryleccalc/P12.bin > /dev/null & pid343=$!
tee < fifo/gul_S1_summary_P12.idx work/gul_S1_summaryaalcalc/P12.idx work/gul_S1_summaryleccalc/P12.idx > /dev/null & pid344=$!
tee < fifo/gul_S1_summary_P13 fifo/gul_S1_eltcalc_P13 fifo/gul_S1_summarycalc_P13 fifo/gul_S1_pltcalc_P13 work/gul_S1_summaryaalcalc/P13.bin work/gul_S1_summaryleccalc/P13.bin > /dev/null & pid345=$!
tee < fifo/gul_S1_summary_P13.idx work/gul_S1_summaryaalcalc/P13.idx work/gul_S1_summaryleccalc/P13.idx > /dev/null & pid346=$!
tee < fifo/gul_S1_summary_P14 fifo/gul_S1_eltcalc_P14 fifo/gul_S1_summarycalc_P14 fifo/gul_S1_pltcalc_P14 work/gul_S1_summaryaalcalc/P14.bin work/gul_S1_summaryleccalc/P14.bin > /dev/null & pid347=$!
tee < fifo/gul_S1_summary_P14.idx work/gul_S1_summaryaalcalc/P14.idx work/gul_S1_summaryleccalc/P14.idx > /dev/null & pid348=$!
tee < fifo/gul_S1_summary_P15 fifo/gul_S1_eltcalc_P15 fifo/gul_S1_summarycalc_P15 fifo/gul_S1_pltcalc_P15 work/gul_S1_summaryaalcalc/P15.bin work/gul_S1_summaryleccalc/P15.bin > /dev/null & pid349=$!
tee < fifo/gul_S1_summary_P15.idx work/gul_S1_summaryaalcalc/P15.idx work/gul_S1_summaryleccalc/P15.idx > /dev/null & pid350=$!
tee < fifo/gul_S1_summary_P16 fifo/gul_S1_eltcalc_P16 fifo/gul_S1_summarycalc_P16 fifo/gul_S1_pltcalc_P16 work/gul_S1_summaryaalcalc/P16.bin work/gul_S1_summaryleccalc/P16.bin > /dev/null & pid351=$!
tee < fifo/gul_S1_summary_P16.idx work/gul_S1_summaryaalcalc/P16.idx work/gul_S1_summaryleccalc/P16.idx > /dev/null & pid352=$!
tee < fifo/gul_S1_summary_P17 fifo/gul_S1_eltcalc_P17 fifo/gul_S1_summarycalc_P17 fifo/gul_S1_pltcalc_P17 work/gul_S1_summaryaalcalc/P17.bin work/gul_S1_summaryleccalc/P17.bin > /dev/null & pid353=$!
tee < fifo/gul_S1_summary_P17.idx work/gul_S1_summaryaalcalc/P17.idx work/gul_S1_summaryleccalc/P17.idx > /dev/null & pid354=$!
tee < fifo/gul_S1_summary_P18 fifo/gul_S1_eltcalc_P18 fifo/gul_S1_summarycalc_P18 fifo/gul_S1_pltcalc_P18 work/gul_S1_summaryaalcalc/P18.bin work/gul_S1_summaryleccalc/P18.bin > /dev/null & pid355=$!
tee < fifo/gul_S1_summary_P18.idx work/gul_S1_summaryaalcalc/P18.idx work/gul_S1_summaryleccalc/P18.idx > /dev/null & pid356=$!
tee < fifo/gul_S1_summary_P19 fifo/gul_S1_eltcalc_P19 fifo/gul_S1_summarycalc_P19 fifo/gul_S1_pltcalc_P19 work/gul_S1_summaryaalcalc/P19.bin work/gul_S1_summaryleccalc/P19.bin > /dev/null & pid357=$!
tee < fifo/gul_S1_summary_P19.idx work/gul_S1_summaryaalcalc/P19.idx work/gul_S1_summaryleccalc/P19.idx > /dev/null & pid358=$!
tee < fifo/gul_S1_summary_P20 fifo/gul_S1_eltcalc_P20 fifo/gul_S1_summarycalc_P20 fifo/gul_S1_pltcalc_P20 work/gul_S1_summaryaalcalc/P20.bin work/gul_S1_summaryleccalc/P20.bin > /dev/null & pid359=$!
tee < fifo/gul_S1_summary_P20.idx work/gul_S1_summaryaalcalc/P20.idx work/gul_S1_summaryleccalc/P20.idx > /dev/null & pid360=$!
tee < fifo/gul_S1_summary_P21 fifo/gul_S1_eltcalc_P21 fifo/gul_S1_summarycalc_P21 fifo/gul_S1_pltcalc_P21 work/gul_S1_summaryaalcalc/P21.bin work/gul_S1_summaryleccalc/P21.bin > /dev/null & pid361=$!
tee < fifo/gul_S1_summary_P21.idx work/gul_S1_summaryaalcalc/P21.idx work/gul_S1_summaryleccalc/P21.idx > /dev/null & pid362=$!
tee < fifo/gul_S1_summary_P22 fifo/gul_S1_eltcalc_P22 fifo/gul_S1_summarycalc_P22 fifo/gul_S1_pltcalc_P22 work/gul_S1_summaryaalcalc/P22.bin work/gul_S1_summaryleccalc/P22.bin > /dev/null & pid363=$!
tee < fifo/gul_S1_summary_P22.idx work/gul_S1_summaryaalcalc/P22.idx work/gul_S1_summaryleccalc/P22.idx > /dev/null & pid364=$!
tee < fifo/gul_S1_summary_P23 fifo/gul_S1_eltcalc_P23 fifo/gul_S1_summarycalc_P23 fifo/gul_S1_pltcalc_P23 work/gul_S1_summaryaalcalc/P23.bin work/gul_S1_summaryleccalc/P23.bin > /dev/null & pid365=$!
tee < fifo/gul_S1_summary_P23.idx work/gul_S1_summaryaalcalc/P23.idx work/gul_S1_summaryleccalc/P23.idx > /dev/null & pid366=$!
tee < fifo/gul_S1_summary_P24 fifo/gul_S1_eltcalc_P24 fifo/gul_S1_summarycalc_P24 fifo/gul_S1_pltcalc_P24 work/gul_S1_summaryaalcalc/P24.bin work/gul_S1_summaryleccalc/P24.bin > /dev/null & pid367=$!
tee < fifo/gul_S1_summary_P24.idx work/gul_S1_summaryaalcalc/P24.idx work/gul_S1_summaryleccalc/P24.idx > /dev/null & pid368=$!
tee < fifo/gul_S1_summary_P25 fifo/gul_S1_eltcalc_P25 fifo/gul_S1_summarycalc_P25 fifo/gul_S1_pltcalc_P25 work/gul_S1_summaryaalcalc/P25.bin work/gul_S1_summaryleccalc/P25.bin > /dev/null & pid369=$!
tee < fifo/gul_S1_summary_P25.idx work/gul_S1_summaryaalcalc/P25.idx work/gul_S1_summaryleccalc/P25.idx > /dev/null & pid370=$!
tee < fifo/gul_S1_summary_P26 fifo/gul_S1_eltcalc_P26 fifo/gul_S1_summarycalc_P26 fifo/gul_S1_pltcalc_P26 work/gul_S1_summaryaalcalc/P26.bin work/gul_S1_summaryleccalc/P26.bin > /dev/null & pid371=$!
tee < fifo/gul_S1_summary_P26.idx work/gul_S1_summaryaalcalc/P26.idx work/gul_S1_summaryleccalc/P26.idx > /dev/null & pid372=$!
tee < fifo/gul_S1_summary_P27 fifo/gul_S1_eltcalc_P27 fifo/gul_S1_summarycalc_P27 fifo/gul_S1_pltcalc_P27 work/gul_S1_summaryaalcalc/P27.bin work/gul_S1_summaryleccalc/P27.bin > /dev/null & pid373=$!
tee < fifo/gul_S1_summary_P27.idx work/gul_S1_summaryaalcalc/P27.idx work/gul_S1_summaryleccalc/P27.idx > /dev/null & pid374=$!
tee < fifo/gul_S1_summary_P28 fifo/gul_S1_eltcalc_P28 fifo/gul_S1_summarycalc_P28 fifo/gul_S1_pltcalc_P28 work/gul_S1_summaryaalcalc/P28.bin work/gul_S1_summaryleccalc/P28.bin > /dev/null & pid375=$!
tee < fifo/gul_S1_summary_P28.idx work/gul_S1_summaryaalcalc/P28.idx work/gul_S1_summaryleccalc/P28.idx > /dev/null & pid376=$!
tee < fifo/gul_S1_summary_P29 fifo/gul_S1_eltcalc_P29 fifo/gul_S1_summarycalc_P29 fifo/gul_S1_pltcalc_P29 work/gul_S1_summaryaalcalc/P29.bin work/gul_S1_summaryleccalc/P29.bin > /dev/null & pid377=$!
tee < fifo/gul_S1_summary_P29.idx work/gul_S1_summaryaalcalc/P29.idx work/gul_S1_summaryleccalc/P29.idx > /dev/null & pid378=$!
tee < fifo/gul_S1_summary_P30 fifo/gul_S1_eltcalc_P30 fifo/gul_S1_summarycalc_P30 fifo/gul_S1_pltcalc_P30 work/gul_S1_summaryaalcalc/P30.bin work/gul_S1_summaryleccalc/P30.bin > /dev/null & pid379=$!
tee < fifo/gul_S1_summary_P30.idx work/gul_S1_summaryaalcalc/P30.idx work/gul_S1_summaryleccalc/P30.idx > /dev/null & pid380=$!
tee < fifo/gul_S1_summary_P31 fifo/gul_S1_eltcalc_P31 fifo/gul_S1_summarycalc_P31 fifo/gul_S1_pltcalc_P31 work/gul_S1_summaryaalcalc/P31.bin work/gul_S1_summaryleccalc/P31.bin > /dev/null & pid381=$!
tee < fifo/gul_S1_summary_P31.idx work/gul_S1_summaryaalcalc/P31.idx work/gul_S1_summaryleccalc/P31.idx > /dev/null & pid382=$!
tee < fifo/gul_S1_summary_P32 fifo/gul_S1_eltcalc_P32 fifo/gul_S1_summarycalc_P32 fifo/gul_S1_pltcalc_P32 work/gul_S1_summaryaalcalc/P32.bin work/gul_S1_summaryleccalc/P32.bin > /dev/null & pid383=$!
tee < fifo/gul_S1_summary_P32.idx work/gul_S1_summaryaalcalc/P32.idx work/gul_S1_summaryleccalc/P32.idx > /dev/null & pid384=$!
tee < fifo/gul_S1_summary_P33 fifo/gul_S1_eltcalc_P33 fifo/gul_S1_summarycalc_P33 fifo/gul_S1_pltcalc_P33 work/gul_S1_summaryaalcalc/P33.bin work/gul_S1_summaryleccalc/P33.bin > /dev/null & pid385=$!
tee < fifo/gul_S1_summary_P33.idx work/gul_S1_summaryaalcalc/P33.idx work/gul_S1_summaryleccalc/P33.idx > /dev/null & pid386=$!
tee < fifo/gul_S1_summary_P34 fifo/gul_S1_eltcalc_P34 fifo/gul_S1_summarycalc_P34 fifo/gul_S1_pltcalc_P34 work/gul_S1_summaryaalcalc/P34.bin work/gul_S1_summaryleccalc/P34.bin > /dev/null & pid387=$!
tee < fifo/gul_S1_summary_P34.idx work/gul_S1_summaryaalcalc/P34.idx work/gul_S1_summaryleccalc/P34.idx > /dev/null & pid388=$!
tee < fifo/gul_S1_summary_P35 fifo/gul_S1_eltcalc_P35 fifo/gul_S1_summarycalc_P35 fifo/gul_S1_pltcalc_P35 work/gul_S1_summaryaalcalc/P35.bin work/gul_S1_summaryleccalc/P35.bin > /dev/null & pid389=$!
tee < fifo/gul_S1_summary_P35.idx work/gul_S1_summaryaalcalc/P35.idx work/gul_S1_summaryleccalc/P35.idx > /dev/null & pid390=$!
tee < fifo/gul_S1_summary_P36 fifo/gul_S1_eltcalc_P36 fifo/gul_S1_summarycalc_P36 fifo/gul_S1_pltcalc_P36 work/gul_S1_summaryaalcalc/P36.bin work/gul_S1_summaryleccalc/P36.bin > /dev/null & pid391=$!
tee < fifo/gul_S1_summary_P36.idx work/gul_S1_summaryaalcalc/P36.idx work/gul_S1_summaryleccalc/P36.idx > /dev/null & pid392=$!
tee < fifo/gul_S1_summary_P37 fifo/gul_S1_eltcalc_P37 fifo/gul_S1_summarycalc_P37 fifo/gul_S1_pltcalc_P37 work/gul_S1_summaryaalcalc/P37.bin work/gul_S1_summaryleccalc/P37.bin > /dev/null & pid393=$!
tee < fifo/gul_S1_summary_P37.idx work/gul_S1_summaryaalcalc/P37.idx work/gul_S1_summaryleccalc/P37.idx > /dev/null & pid394=$!
tee < fifo/gul_S1_summary_P38 fifo/gul_S1_eltcalc_P38 fifo/gul_S1_summarycalc_P38 fifo/gul_S1_pltcalc_P38 work/gul_S1_summaryaalcalc/P38.bin work/gul_S1_summaryleccalc/P38.bin > /dev/null & pid395=$!
tee < fifo/gul_S1_summary_P38.idx work/gul_S1_summaryaalcalc/P38.idx work/gul_S1_summaryleccalc/P38.idx > /dev/null & pid396=$!
tee < fifo/gul_S1_summary_P39 fifo/gul_S1_eltcalc_P39 fifo/gul_S1_summarycalc_P39 fifo/gul_S1_pltcalc_P39 work/gul_S1_summaryaalcalc/P39.bin work/gul_S1_summaryleccalc/P39.bin > /dev/null & pid397=$!
tee < fifo/gul_S1_summary_P39.idx work/gul_S1_summaryaalcalc/P39.idx work/gul_S1_summaryleccalc/P39.idx > /dev/null & pid398=$!
tee < fifo/gul_S1_summary_P40 fifo/gul_S1_eltcalc_P40 fifo/gul_S1_summarycalc_P40 fifo/gul_S1_pltcalc_P40 work/gul_S1_summaryaalcalc/P40.bin work/gul_S1_summaryleccalc/P40.bin > /dev/null & pid399=$!
tee < fifo/gul_S1_summary_P40.idx work/gul_S1_summaryaalcalc/P40.idx work/gul_S1_summaryleccalc/P40.idx > /dev/null & pid400=$!

summarycalc -m -i  -1 fifo/gul_S1_summary_P1 < fifo/gul_P1 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P2 < fifo/gul_P2 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P3 < fifo/gul_P3 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P4 < fifo/gul_P4 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P5 < fifo/gul_P5 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P6 < fifo/gul_P6 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P7 < fifo/gul_P7 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P8 < fifo/gul_P8 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P9 < fifo/gul_P9 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P10 < fifo/gul_P10 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P11 < fifo/gul_P11 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P12 < fifo/gul_P12 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P13 < fifo/gul_P13 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P14 < fifo/gul_P14 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P15 < fifo/gul_P15 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P16 < fifo/gul_P16 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P17 < fifo/gul_P17 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P18 < fifo/gul_P18 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P19 < fifo/gul_P19 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P20 < fifo/gul_P20 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P21 < fifo/gul_P21 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P22 < fifo/gul_P22 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P23 < fifo/gul_P23 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P24 < fifo/gul_P24 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P25 < fifo/gul_P25 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P26 < fifo/gul_P26 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P27 < fifo/gul_P27 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P28 < fifo/gul_P28 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P29 < fifo/gul_P29 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P30 < fifo/gul_P30 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P31 < fifo/gul_P31 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P32 < fifo/gul_P32 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P33 < fifo/gul_P33 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P34 < fifo/gul_P34 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P35 < fifo/gul_P35 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P36 < fifo/gul_P36 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P37 < fifo/gul_P37 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P38 < fifo/gul_P38 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P39 < fifo/gul_P39 &
summarycalc -m -i  -1 fifo/gul_S1_summary_P40 < fifo/gul_P40 &

# --- Do insured loss computes ---

eltcalc < fifo/full_correlation/il_S1_eltcalc_P1 > work/full_correlation/kat/il_S1_eltcalc_P1 & pid401=$!
summarycalctocsv < fifo/full_correlation/il_S1_summarycalc_P1 > work/full_correlation/kat/il_S1_summarycalc_P1 & pid402=$!
pltcalc < fifo/full_correlation/il_S1_pltcalc_P1 > work/full_correlation/kat/il_S1_pltcalc_P1 & pid403=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P2 > work/full_correlation/kat/il_S1_eltcalc_P2 & pid404=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P2 > work/full_correlation/kat/il_S1_summarycalc_P2 & pid405=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P2 > work/full_correlation/kat/il_S1_pltcalc_P2 & pid406=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P3 > work/full_correlation/kat/il_S1_eltcalc_P3 & pid407=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P3 > work/full_correlation/kat/il_S1_summarycalc_P3 & pid408=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P3 > work/full_correlation/kat/il_S1_pltcalc_P3 & pid409=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P4 > work/full_correlation/kat/il_S1_eltcalc_P4 & pid410=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P4 > work/full_correlation/kat/il_S1_summarycalc_P4 & pid411=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P4 > work/full_correlation/kat/il_S1_pltcalc_P4 & pid412=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P5 > work/full_correlation/kat/il_S1_eltcalc_P5 & pid413=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P5 > work/full_correlation/kat/il_S1_summarycalc_P5 & pid414=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P5 > work/full_correlation/kat/il_S1_pltcalc_P5 & pid415=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P6 > work/full_correlation/kat/il_S1_eltcalc_P6 & pid416=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P6 > work/full_correlation/kat/il_S1_summarycalc_P6 & pid417=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P6 > work/full_correlation/kat/il_S1_pltcalc_P6 & pid418=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P7 > work/full_correlation/kat/il_S1_eltcalc_P7 & pid419=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P7 > work/full_correlation/kat/il_S1_summarycalc_P7 & pid420=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P7 > work/full_correlation/kat/il_S1_pltcalc_P7 & pid421=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P8 > work/full_correlation/kat/il_S1_eltcalc_P8 & pid422=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P8 > work/full_correlation/kat/il_S1_summarycalc_P8 & pid423=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P8 > work/full_correlation/kat/il_S1_pltcalc_P8 & pid424=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P9 > work/full_correlation/kat/il_S1_eltcalc_P9 & pid425=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P9 > work/full_correlation/kat/il_S1_summarycalc_P9 & pid426=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P9 > work/full_correlation/kat/il_S1_pltcalc_P9 & pid427=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P10 > work/full_correlation/kat/il_S1_eltcalc_P10 & pid428=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P10 > work/full_correlation/kat/il_S1_summarycalc_P10 & pid429=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P10 > work/full_correlation/kat/il_S1_pltcalc_P10 & pid430=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P11 > work/full_correlation/kat/il_S1_eltcalc_P11 & pid431=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P11 > work/full_correlation/kat/il_S1_summarycalc_P11 & pid432=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P11 > work/full_correlation/kat/il_S1_pltcalc_P11 & pid433=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P12 > work/full_correlation/kat/il_S1_eltcalc_P12 & pid434=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P12 > work/full_correlation/kat/il_S1_summarycalc_P12 & pid435=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P12 > work/full_correlation/kat/il_S1_pltcalc_P12 & pid436=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P13 > work/full_correlation/kat/il_S1_eltcalc_P13 & pid437=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P13 > work/full_correlation/kat/il_S1_summarycalc_P13 & pid438=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P13 > work/full_correlation/kat/il_S1_pltcalc_P13 & pid439=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P14 > work/full_correlation/kat/il_S1_eltcalc_P14 & pid440=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P14 > work/full_correlation/kat/il_S1_summarycalc_P14 & pid441=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P14 > work/full_correlation/kat/il_S1_pltcalc_P14 & pid442=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P15 > work/full_correlation/kat/il_S1_eltcalc_P15 & pid443=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P15 > work/full_correlation/kat/il_S1_summarycalc_P15 & pid444=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P15 > work/full_correlation/kat/il_S1_pltcalc_P15 & pid445=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P16 > work/full_correlation/kat/il_S1_eltcalc_P16 & pid446=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P16 > work/full_correlation/kat/il_S1_summarycalc_P16 & pid447=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P16 > work/full_correlation/kat/il_S1_pltcalc_P16 & pid448=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P17 > work/full_correlation/kat/il_S1_eltcalc_P17 & pid449=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P17 > work/full_correlation/kat/il_S1_summarycalc_P17 & pid450=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P17 > work/full_correlation/kat/il_S1_pltcalc_P17 & pid451=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P18 > work/full_correlation/kat/il_S1_eltcalc_P18 & pid452=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P18 > work/full_correlation/kat/il_S1_summarycalc_P18 & pid453=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P18 > work/full_correlation/kat/il_S1_pltcalc_P18 & pid454=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P19 > work/full_correlation/kat/il_S1_eltcalc_P19 & pid455=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P19 > work/full_correlation/kat/il_S1_summarycalc_P19 & pid456=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P19 > work/full_correlation/kat/il_S1_pltcalc_P19 & pid457=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P20 > work/full_correlation/kat/il_S1_eltcalc_P20 & pid458=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P20 > work/full_correlation/kat/il_S1_summarycalc_P20 & pid459=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P20 > work/full_correlation/kat/il_S1_pltcalc_P20 & pid460=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P21 > work/full_correlation/kat/il_S1_eltcalc_P21 & pid461=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P21 > work/full_correlation/kat/il_S1_summarycalc_P21 & pid462=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P21 > work/full_correlation/kat/il_S1_pltcalc_P21 & pid463=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P22 > work/full_correlation/kat/il_S1_eltcalc_P22 & pid464=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P22 > work/full_correlation/kat/il_S1_summarycalc_P22 & pid465=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P22 > work/full_correlation/kat/il_S1_pltcalc_P22 & pid466=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P23 > work/full_correlation/kat/il_S1_eltcalc_P23 & pid467=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P23 > work/full_correlation/kat/il_S1_summarycalc_P23 & pid468=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P23 > work/full_correlation/kat/il_S1_pltcalc_P23 & pid469=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P24 > work/full_correlation/kat/il_S1_eltcalc_P24 & pid470=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P24 > work/full_correlation/kat/il_S1_summarycalc_P24 & pid471=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P24 > work/full_correlation/kat/il_S1_pltcalc_P24 & pid472=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P25 > work/full_correlation/kat/il_S1_eltcalc_P25 & pid473=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P25 > work/full_correlation/kat/il_S1_summarycalc_P25 & pid474=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P25 > work/full_correlation/kat/il_S1_pltcalc_P25 & pid475=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P26 > work/full_correlation/kat/il_S1_eltcalc_P26 & pid476=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P26 > work/full_correlation/kat/il_S1_summarycalc_P26 & pid477=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P26 > work/full_correlation/kat/il_S1_pltcalc_P26 & pid478=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P27 > work/full_correlation/kat/il_S1_eltcalc_P27 & pid479=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P27 > work/full_correlation/kat/il_S1_summarycalc_P27 & pid480=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P27 > work/full_correlation/kat/il_S1_pltcalc_P27 & pid481=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P28 > work/full_correlation/kat/il_S1_eltcalc_P28 & pid482=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P28 > work/full_correlation/kat/il_S1_summarycalc_P28 & pid483=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P28 > work/full_correlation/kat/il_S1_pltcalc_P28 & pid484=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P29 > work/full_correlation/kat/il_S1_eltcalc_P29 & pid485=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P29 > work/full_correlation/kat/il_S1_summarycalc_P29 & pid486=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P29 > work/full_correlation/kat/il_S1_pltcalc_P29 & pid487=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P30 > work/full_correlation/kat/il_S1_eltcalc_P30 & pid488=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P30 > work/full_correlation/kat/il_S1_summarycalc_P30 & pid489=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P30 > work/full_correlation/kat/il_S1_pltcalc_P30 & pid490=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P31 > work/full_correlation/kat/il_S1_eltcalc_P31 & pid491=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P31 > work/full_correlation/kat/il_S1_summarycalc_P31 & pid492=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P31 > work/full_correlation/kat/il_S1_pltcalc_P31 & pid493=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P32 > work/full_correlation/kat/il_S1_eltcalc_P32 & pid494=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P32 > work/full_correlation/kat/il_S1_summarycalc_P32 & pid495=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P32 > work/full_correlation/kat/il_S1_pltcalc_P32 & pid496=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P33 > work/full_correlation/kat/il_S1_eltcalc_P33 & pid497=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P33 > work/full_correlation/kat/il_S1_summarycalc_P33 & pid498=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P33 > work/full_correlation/kat/il_S1_pltcalc_P33 & pid499=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P34 > work/full_correlation/kat/il_S1_eltcalc_P34 & pid500=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P34 > work/full_correlation/kat/il_S1_summarycalc_P34 & pid501=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P34 > work/full_correlation/kat/il_S1_pltcalc_P34 & pid502=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P35 > work/full_correlation/kat/il_S1_eltcalc_P35 & pid503=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P35 > work/full_correlation/kat/il_S1_summarycalc_P35 & pid504=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P35 > work/full_correlation/kat/il_S1_pltcalc_P35 & pid505=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P36 > work/full_correlation/kat/il_S1_eltcalc_P36 & pid506=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P36 > work/full_correlation/kat/il_S1_summarycalc_P36 & pid507=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P36 > work/full_correlation/kat/il_S1_pltcalc_P36 & pid508=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P37 > work/full_correlation/kat/il_S1_eltcalc_P37 & pid509=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P37 > work/full_correlation/kat/il_S1_summarycalc_P37 & pid510=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P37 > work/full_correlation/kat/il_S1_pltcalc_P37 & pid511=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P38 > work/full_correlation/kat/il_S1_eltcalc_P38 & pid512=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P38 > work/full_correlation/kat/il_S1_summarycalc_P38 & pid513=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P38 > work/full_correlation/kat/il_S1_pltcalc_P38 & pid514=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P39 > work/full_correlation/kat/il_S1_eltcalc_P39 & pid515=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P39 > work/full_correlation/kat/il_S1_summarycalc_P39 & pid516=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P39 > work/full_correlation/kat/il_S1_pltcalc_P39 & pid517=$!
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P40 > work/full_correlation/kat/il_S1_eltcalc_P40 & pid518=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P40 > work/full_correlation/kat/il_S1_summarycalc_P40 & pid519=$!
pltcalc -H < fifo/full_correlation/il_S1_pltcalc_P40 > work/full_correlation/kat/il_S1_pltcalc_P40 & pid520=$!


tee < fifo/full_correlation/il_S1_summary_P1 fifo/full_correlation/il_S1_eltcalc_P1 fifo/full_correlation/il_S1_summarycalc_P1 fifo/full_correlation/il_S1_pltcalc_P1 work/full_correlation/il_S1_summaryaalcalc/P1.bin work/full_correlation/il_S1_summaryleccalc/P1.bin > /dev/null & pid521=$!
tee < fifo/full_correlation/il_S1_summary_P1.idx work/full_correlation/il_S1_summaryaalcalc/P1.idx work/full_correlation/il_S1_summaryleccalc/P1.idx > /dev/null & pid522=$!
tee < fifo/full_correlation/il_S1_summary_P2 fifo/full_correlation/il_S1_eltcalc_P2 fifo/full_correlation/il_S1_summarycalc_P2 fifo/full_correlation/il_S1_pltcalc_P2 work/full_correlation/il_S1_summaryaalcalc/P2.bin work/full_correlation/il_S1_summaryleccalc/P2.bin > /dev/null & pid523=$!
tee < fifo/full_correlation/il_S1_summary_P2.idx work/full_correlation/il_S1_summaryaalcalc/P2.idx work/full_correlation/il_S1_summaryleccalc/P2.idx > /dev/null & pid524=$!
tee < fifo/full_correlation/il_S1_summary_P3 fifo/full_correlation/il_S1_eltcalc_P3 fifo/full_correlation/il_S1_summarycalc_P3 fifo/full_correlation/il_S1_pltcalc_P3 work/full_correlation/il_S1_summaryaalcalc/P3.bin work/full_correlation/il_S1_summaryleccalc/P3.bin > /dev/null & pid525=$!
tee < fifo/full_correlation/il_S1_summary_P3.idx work/full_correlation/il_S1_summaryaalcalc/P3.idx work/full_correlation/il_S1_summaryleccalc/P3.idx > /dev/null & pid526=$!
tee < fifo/full_correlation/il_S1_summary_P4 fifo/full_correlation/il_S1_eltcalc_P4 fifo/full_correlation/il_S1_summarycalc_P4 fifo/full_correlation/il_S1_pltcalc_P4 work/full_correlation/il_S1_summaryaalcalc/P4.bin work/full_correlation/il_S1_summaryleccalc/P4.bin > /dev/null & pid527=$!
tee < fifo/full_correlation/il_S1_summary_P4.idx work/full_correlation/il_S1_summaryaalcalc/P4.idx work/full_correlation/il_S1_summaryleccalc/P4.idx > /dev/null & pid528=$!
tee < fifo/full_correlation/il_S1_summary_P5 fifo/full_correlation/il_S1_eltcalc_P5 fifo/full_correlation/il_S1_summarycalc_P5 fifo/full_correlation/il_S1_pltcalc_P5 work/full_correlation/il_S1_summaryaalcalc/P5.bin work/full_correlation/il_S1_summaryleccalc/P5.bin > /dev/null & pid529=$!
tee < fifo/full_correlation/il_S1_summary_P5.idx work/full_correlation/il_S1_summaryaalcalc/P5.idx work/full_correlation/il_S1_summaryleccalc/P5.idx > /dev/null & pid530=$!
tee < fifo/full_correlation/il_S1_summary_P6 fifo/full_correlation/il_S1_eltcalc_P6 fifo/full_correlation/il_S1_summarycalc_P6 fifo/full_correlation/il_S1_pltcalc_P6 work/full_correlation/il_S1_summaryaalcalc/P6.bin work/full_correlation/il_S1_summaryleccalc/P6.bin > /dev/null & pid531=$!
tee < fifo/full_correlation/il_S1_summary_P6.idx work/full_correlation/il_S1_summaryaalcalc/P6.idx work/full_correlation/il_S1_summaryleccalc/P6.idx > /dev/null & pid532=$!
tee < fifo/full_correlation/il_S1_summary_P7 fifo/full_correlation/il_S1_eltcalc_P7 fifo/full_correlation/il_S1_summarycalc_P7 fifo/full_correlation/il_S1_pltcalc_P7 work/full_correlation/il_S1_summaryaalcalc/P7.bin work/full_correlation/il_S1_summaryleccalc/P7.bin > /dev/null & pid533=$!
tee < fifo/full_correlation/il_S1_summary_P7.idx work/full_correlation/il_S1_summaryaalcalc/P7.idx work/full_correlation/il_S1_summaryleccalc/P7.idx > /dev/null & pid534=$!
tee < fifo/full_correlation/il_S1_summary_P8 fifo/full_correlation/il_S1_eltcalc_P8 fifo/full_correlation/il_S1_summarycalc_P8 fifo/full_correlation/il_S1_pltcalc_P8 work/full_correlation/il_S1_summaryaalcalc/P8.bin work/full_correlation/il_S1_summaryleccalc/P8.bin > /dev/null & pid535=$!
tee < fifo/full_correlation/il_S1_summary_P8.idx work/full_correlation/il_S1_summaryaalcalc/P8.idx work/full_correlation/il_S1_summaryleccalc/P8.idx > /dev/null & pid536=$!
tee < fifo/full_correlation/il_S1_summary_P9 fifo/full_correlation/il_S1_eltcalc_P9 fifo/full_correlation/il_S1_summarycalc_P9 fifo/full_correlation/il_S1_pltcalc_P9 work/full_correlation/il_S1_summaryaalcalc/P9.bin work/full_correlation/il_S1_summaryleccalc/P9.bin > /dev/null & pid537=$!
tee < fifo/full_correlation/il_S1_summary_P9.idx work/full_correlation/il_S1_summaryaalcalc/P9.idx work/full_correlation/il_S1_summaryleccalc/P9.idx > /dev/null & pid538=$!
tee < fifo/full_correlation/il_S1_summary_P10 fifo/full_correlation/il_S1_eltcalc_P10 fifo/full_correlation/il_S1_summarycalc_P10 fifo/full_correlation/il_S1_pltcalc_P10 work/full_correlation/il_S1_summaryaalcalc/P10.bin work/full_correlation/il_S1_summaryleccalc/P10.bin > /dev/null & pid539=$!
tee < fifo/full_correlation/il_S1_summary_P10.idx work/full_correlation/il_S1_summaryaalcalc/P10.idx work/full_correlation/il_S1_summaryleccalc/P10.idx > /dev/null & pid540=$!
tee < fifo/full_correlation/il_S1_summary_P11 fifo/full_correlation/il_S1_eltcalc_P11 fifo/full_correlation/il_S1_summarycalc_P11 fifo/full_correlation/il_S1_pltcalc_P11 work/full_correlation/il_S1_summaryaalcalc/P11.bin work/full_correlation/il_S1_summaryleccalc/P11.bin > /dev/null & pid541=$!
tee < fifo/full_correlation/il_S1_summary_P11.idx work/full_correlation/il_S1_summaryaalcalc/P11.idx work/full_correlation/il_S1_summaryleccalc/P11.idx > /dev/null & pid542=$!
tee < fifo/full_correlation/il_S1_summary_P12 fifo/full_correlation/il_S1_eltcalc_P12 fifo/full_correlation/il_S1_summarycalc_P12 fifo/full_correlation/il_S1_pltcalc_P12 work/full_correlation/il_S1_summaryaalcalc/P12.bin work/full_correlation/il_S1_summaryleccalc/P12.bin > /dev/null & pid543=$!
tee < fifo/full_correlation/il_S1_summary_P12.idx work/full_correlation/il_S1_summaryaalcalc/P12.idx work/full_correlation/il_S1_summaryleccalc/P12.idx > /dev/null & pid544=$!
tee < fifo/full_correlation/il_S1_summary_P13 fifo/full_correlation/il_S1_eltcalc_P13 fifo/full_correlation/il_S1_summarycalc_P13 fifo/full_correlation/il_S1_pltcalc_P13 work/full_correlation/il_S1_summaryaalcalc/P13.bin work/full_correlation/il_S1_summaryleccalc/P13.bin > /dev/null & pid545=$!
tee < fifo/full_correlation/il_S1_summary_P13.idx work/full_correlation/il_S1_summaryaalcalc/P13.idx work/full_correlation/il_S1_summaryleccalc/P13.idx > /dev/null & pid546=$!
tee < fifo/full_correlation/il_S1_summary_P14 fifo/full_correlation/il_S1_eltcalc_P14 fifo/full_correlation/il_S1_summarycalc_P14 fifo/full_correlation/il_S1_pltcalc_P14 work/full_correlation/il_S1_summaryaalcalc/P14.bin work/full_correlation/il_S1_summaryleccalc/P14.bin > /dev/null & pid547=$!
tee < fifo/full_correlation/il_S1_summary_P14.idx work/full_correlation/il_S1_summaryaalcalc/P14.idx work/full_correlation/il_S1_summaryleccalc/P14.idx > /dev/null & pid548=$!
tee < fifo/full_correlation/il_S1_summary_P15 fifo/full_correlation/il_S1_eltcalc_P15 fifo/full_correlation/il_S1_summarycalc_P15 fifo/full_correlation/il_S1_pltcalc_P15 work/full_correlation/il_S1_summaryaalcalc/P15.bin work/full_correlation/il_S1_summaryleccalc/P15.bin > /dev/null & pid549=$!
tee < fifo/full_correlation/il_S1_summary_P15.idx work/full_correlation/il_S1_summaryaalcalc/P15.idx work/full_correlation/il_S1_summaryleccalc/P15.idx > /dev/null & pid550=$!
tee < fifo/full_correlation/il_S1_summary_P16 fifo/full_correlation/il_S1_eltcalc_P16 fifo/full_correlation/il_S1_summarycalc_P16 fifo/full_correlation/il_S1_pltcalc_P16 work/full_correlation/il_S1_summaryaalcalc/P16.bin work/full_correlation/il_S1_summaryleccalc/P16.bin > /dev/null & pid551=$!
tee < fifo/full_correlation/il_S1_summary_P16.idx work/full_correlation/il_S1_summaryaalcalc/P16.idx work/full_correlation/il_S1_summaryleccalc/P16.idx > /dev/null & pid552=$!
tee < fifo/full_correlation/il_S1_summary_P17 fifo/full_correlation/il_S1_eltcalc_P17 fifo/full_correlation/il_S1_summarycalc_P17 fifo/full_correlation/il_S1_pltcalc_P17 work/full_correlation/il_S1_summaryaalcalc/P17.bin work/full_correlation/il_S1_summaryleccalc/P17.bin > /dev/null & pid553=$!
tee < fifo/full_correlation/il_S1_summary_P17.idx work/full_correlation/il_S1_summaryaalcalc/P17.idx work/full_correlation/il_S1_summaryleccalc/P17.idx > /dev/null & pid554=$!
tee < fifo/full_correlation/il_S1_summary_P18 fifo/full_correlation/il_S1_eltcalc_P18 fifo/full_correlation/il_S1_summarycalc_P18 fifo/full_correlation/il_S1_pltcalc_P18 work/full_correlation/il_S1_summaryaalcalc/P18.bin work/full_correlation/il_S1_summaryleccalc/P18.bin > /dev/null & pid555=$!
tee < fifo/full_correlation/il_S1_summary_P18.idx work/full_correlation/il_S1_summaryaalcalc/P18.idx work/full_correlation/il_S1_summaryleccalc/P18.idx > /dev/null & pid556=$!
tee < fifo/full_correlation/il_S1_summary_P19 fifo/full_correlation/il_S1_eltcalc_P19 fifo/full_correlation/il_S1_summarycalc_P19 fifo/full_correlation/il_S1_pltcalc_P19 work/full_correlation/il_S1_summaryaalcalc/P19.bin work/full_correlation/il_S1_summaryleccalc/P19.bin > /dev/null & pid557=$!
tee < fifo/full_correlation/il_S1_summary_P19.idx work/full_correlation/il_S1_summaryaalcalc/P19.idx work/full_correlation/il_S1_summaryleccalc/P19.idx > /dev/null & pid558=$!
tee < fifo/full_correlation/il_S1_summary_P20 fifo/full_correlation/il_S1_eltcalc_P20 fifo/full_correlation/il_S1_summarycalc_P20 fifo/full_correlation/il_S1_pltcalc_P20 work/full_correlation/il_S1_summaryaalcalc/P20.bin work/full_correlation/il_S1_summaryleccalc/P20.bin > /dev/null & pid559=$!
tee < fifo/full_correlation/il_S1_summary_P20.idx work/full_correlation/il_S1_summaryaalcalc/P20.idx work/full_correlation/il_S1_summaryleccalc/P20.idx > /dev/null & pid560=$!
tee < fifo/full_correlation/il_S1_summary_P21 fifo/full_correlation/il_S1_eltcalc_P21 fifo/full_correlation/il_S1_summarycalc_P21 fifo/full_correlation/il_S1_pltcalc_P21 work/full_correlation/il_S1_summaryaalcalc/P21.bin work/full_correlation/il_S1_summaryleccalc/P21.bin > /dev/null & pid561=$!
tee < fifo/full_correlation/il_S1_summary_P21.idx work/full_correlation/il_S1_summaryaalcalc/P21.idx work/full_correlation/il_S1_summaryleccalc/P21.idx > /dev/null & pid562=$!
tee < fifo/full_correlation/il_S1_summary_P22 fifo/full_correlation/il_S1_eltcalc_P22 fifo/full_correlation/il_S1_summarycalc_P22 fifo/full_correlation/il_S1_pltcalc_P22 work/full_correlation/il_S1_summaryaalcalc/P22.bin work/full_correlation/il_S1_summaryleccalc/P22.bin > /dev/null & pid563=$!
tee < fifo/full_correlation/il_S1_summary_P22.idx work/full_correlation/il_S1_summaryaalcalc/P22.idx work/full_correlation/il_S1_summaryleccalc/P22.idx > /dev/null & pid564=$!
tee < fifo/full_correlation/il_S1_summary_P23 fifo/full_correlation/il_S1_eltcalc_P23 fifo/full_correlation/il_S1_summarycalc_P23 fifo/full_correlation/il_S1_pltcalc_P23 work/full_correlation/il_S1_summaryaalcalc/P23.bin work/full_correlation/il_S1_summaryleccalc/P23.bin > /dev/null & pid565=$!
tee < fifo/full_correlation/il_S1_summary_P23.idx work/full_correlation/il_S1_summaryaalcalc/P23.idx work/full_correlation/il_S1_summaryleccalc/P23.idx > /dev/null & pid566=$!
tee < fifo/full_correlation/il_S1_summary_P24 fifo/full_correlation/il_S1_eltcalc_P24 fifo/full_correlation/il_S1_summarycalc_P24 fifo/full_correlation/il_S1_pltcalc_P24 work/full_correlation/il_S1_summaryaalcalc/P24.bin work/full_correlation/il_S1_summaryleccalc/P24.bin > /dev/null & pid567=$!
tee < fifo/full_correlation/il_S1_summary_P24.idx work/full_correlation/il_S1_summaryaalcalc/P24.idx work/full_correlation/il_S1_summaryleccalc/P24.idx > /dev/null & pid568=$!
tee < fifo/full_correlation/il_S1_summary_P25 fifo/full_correlation/il_S1_eltcalc_P25 fifo/full_correlation/il_S1_summarycalc_P25 fifo/full_correlation/il_S1_pltcalc_P25 work/full_correlation/il_S1_summaryaalcalc/P25.bin work/full_correlation/il_S1_summaryleccalc/P25.bin > /dev/null & pid569=$!
tee < fifo/full_correlation/il_S1_summary_P25.idx work/full_correlation/il_S1_summaryaalcalc/P25.idx work/full_correlation/il_S1_summaryleccalc/P25.idx > /dev/null & pid570=$!
tee < fifo/full_correlation/il_S1_summary_P26 fifo/full_correlation/il_S1_eltcalc_P26 fifo/full_correlation/il_S1_summarycalc_P26 fifo/full_correlation/il_S1_pltcalc_P26 work/full_correlation/il_S1_summaryaalcalc/P26.bin work/full_correlation/il_S1_summaryleccalc/P26.bin > /dev/null & pid571=$!
tee < fifo/full_correlation/il_S1_summary_P26.idx work/full_correlation/il_S1_summaryaalcalc/P26.idx work/full_correlation/il_S1_summaryleccalc/P26.idx > /dev/null & pid572=$!
tee < fifo/full_correlation/il_S1_summary_P27 fifo/full_correlation/il_S1_eltcalc_P27 fifo/full_correlation/il_S1_summarycalc_P27 fifo/full_correlation/il_S1_pltcalc_P27 work/full_correlation/il_S1_summaryaalcalc/P27.bin work/full_correlation/il_S1_summaryleccalc/P27.bin > /dev/null & pid573=$!
tee < fifo/full_correlation/il_S1_summary_P27.idx work/full_correlation/il_S1_summaryaalcalc/P27.idx work/full_correlation/il_S1_summaryleccalc/P27.idx > /dev/null & pid574=$!
tee < fifo/full_correlation/il_S1_summary_P28 fifo/full_correlation/il_S1_eltcalc_P28 fifo/full_correlation/il_S1_summarycalc_P28 fifo/full_correlation/il_S1_pltcalc_P28 work/full_correlation/il_S1_summaryaalcalc/P28.bin work/full_correlation/il_S1_summaryleccalc/P28.bin > /dev/null & pid575=$!
tee < fifo/full_correlation/il_S1_summary_P28.idx work/full_correlation/il_S1_summaryaalcalc/P28.idx work/full_correlation/il_S1_summaryleccalc/P28.idx > /dev/null & pid576=$!
tee < fifo/full_correlation/il_S1_summary_P29 fifo/full_correlation/il_S1_eltcalc_P29 fifo/full_correlation/il_S1_summarycalc_P29 fifo/full_correlation/il_S1_pltcalc_P29 work/full_correlation/il_S1_summaryaalcalc/P29.bin work/full_correlation/il_S1_summaryleccalc/P29.bin > /dev/null & pid577=$!
tee < fifo/full_correlation/il_S1_summary_P29.idx work/full_correlation/il_S1_summaryaalcalc/P29.idx work/full_correlation/il_S1_summaryleccalc/P29.idx > /dev/null & pid578=$!
tee < fifo/full_correlation/il_S1_summary_P30 fifo/full_correlation/il_S1_eltcalc_P30 fifo/full_correlation/il_S1_summarycalc_P30 fifo/full_correlation/il_S1_pltcalc_P30 work/full_correlation/il_S1_summaryaalcalc/P30.bin work/full_correlation/il_S1_summaryleccalc/P30.bin > /dev/null & pid579=$!
tee < fifo/full_correlation/il_S1_summary_P30.idx work/full_correlation/il_S1_summaryaalcalc/P30.idx work/full_correlation/il_S1_summaryleccalc/P30.idx > /dev/null & pid580=$!
tee < fifo/full_correlation/il_S1_summary_P31 fifo/full_correlation/il_S1_eltcalc_P31 fifo/full_correlation/il_S1_summarycalc_P31 fifo/full_correlation/il_S1_pltcalc_P31 work/full_correlation/il_S1_summaryaalcalc/P31.bin work/full_correlation/il_S1_summaryleccalc/P31.bin > /dev/null & pid581=$!
tee < fifo/full_correlation/il_S1_summary_P31.idx work/full_correlation/il_S1_summaryaalcalc/P31.idx work/full_correlation/il_S1_summaryleccalc/P31.idx > /dev/null & pid582=$!
tee < fifo/full_correlation/il_S1_summary_P32 fifo/full_correlation/il_S1_eltcalc_P32 fifo/full_correlation/il_S1_summarycalc_P32 fifo/full_correlation/il_S1_pltcalc_P32 work/full_correlation/il_S1_summaryaalcalc/P32.bin work/full_correlation/il_S1_summaryleccalc/P32.bin > /dev/null & pid583=$!
tee < fifo/full_correlation/il_S1_summary_P32.idx work/full_correlation/il_S1_summaryaalcalc/P32.idx work/full_correlation/il_S1_summaryleccalc/P32.idx > /dev/null & pid584=$!
tee < fifo/full_correlation/il_S1_summary_P33 fifo/full_correlation/il_S1_eltcalc_P33 fifo/full_correlation/il_S1_summarycalc_P33 fifo/full_correlation/il_S1_pltcalc_P33 work/full_correlation/il_S1_summaryaalcalc/P33.bin work/full_correlation/il_S1_summaryleccalc/P33.bin > /dev/null & pid585=$!
tee < fifo/full_correlation/il_S1_summary_P33.idx work/full_correlation/il_S1_summaryaalcalc/P33.idx work/full_correlation/il_S1_summaryleccalc/P33.idx > /dev/null & pid586=$!
tee < fifo/full_correlation/il_S1_summary_P34 fifo/full_correlation/il_S1_eltcalc_P34 fifo/full_correlation/il_S1_summarycalc_P34 fifo/full_correlation/il_S1_pltcalc_P34 work/full_correlation/il_S1_summaryaalcalc/P34.bin work/full_correlation/il_S1_summaryleccalc/P34.bin > /dev/null & pid587=$!
tee < fifo/full_correlation/il_S1_summary_P34.idx work/full_correlation/il_S1_summaryaalcalc/P34.idx work/full_correlation/il_S1_summaryleccalc/P34.idx > /dev/null & pid588=$!
tee < fifo/full_correlation/il_S1_summary_P35 fifo/full_correlation/il_S1_eltcalc_P35 fifo/full_correlation/il_S1_summarycalc_P35 fifo/full_correlation/il_S1_pltcalc_P35 work/full_correlation/il_S1_summaryaalcalc/P35.bin work/full_correlation/il_S1_summaryleccalc/P35.bin > /dev/null & pid589=$!
tee < fifo/full_correlation/il_S1_summary_P35.idx work/full_correlation/il_S1_summaryaalcalc/P35.idx work/full_correlation/il_S1_summaryleccalc/P35.idx > /dev/null & pid590=$!
tee < fifo/full_correlation/il_S1_summary_P36 fifo/full_correlation/il_S1_eltcalc_P36 fifo/full_correlation/il_S1_summarycalc_P36 fifo/full_correlation/il_S1_pltcalc_P36 work/full_correlation/il_S1_summaryaalcalc/P36.bin work/full_correlation/il_S1_summaryleccalc/P36.bin > /dev/null & pid591=$!
tee < fifo/full_correlation/il_S1_summary_P36.idx work/full_correlation/il_S1_summaryaalcalc/P36.idx work/full_correlation/il_S1_summaryleccalc/P36.idx > /dev/null & pid592=$!
tee < fifo/full_correlation/il_S1_summary_P37 fifo/full_correlation/il_S1_eltcalc_P37 fifo/full_correlation/il_S1_summarycalc_P37 fifo/full_correlation/il_S1_pltcalc_P37 work/full_correlation/il_S1_summaryaalcalc/P37.bin work/full_correlation/il_S1_summaryleccalc/P37.bin > /dev/null & pid593=$!
tee < fifo/full_correlation/il_S1_summary_P37.idx work/full_correlation/il_S1_summaryaalcalc/P37.idx work/full_correlation/il_S1_summaryleccalc/P37.idx > /dev/null & pid594=$!
tee < fifo/full_correlation/il_S1_summary_P38 fifo/full_correlation/il_S1_eltcalc_P38 fifo/full_correlation/il_S1_summarycalc_P38 fifo/full_correlation/il_S1_pltcalc_P38 work/full_correlation/il_S1_summaryaalcalc/P38.bin work/full_correlation/il_S1_summaryleccalc/P38.bin > /dev/null & pid595=$!
tee < fifo/full_correlation/il_S1_summary_P38.idx work/full_correlation/il_S1_summaryaalcalc/P38.idx work/full_correlation/il_S1_summaryleccalc/P38.idx > /dev/null & pid596=$!
tee < fifo/full_correlation/il_S1_summary_P39 fifo/full_correlation/il_S1_eltcalc_P39 fifo/full_correlation/il_S1_summarycalc_P39 fifo/full_correlation/il_S1_pltcalc_P39 work/full_correlation/il_S1_summaryaalcalc/P39.bin work/full_correlation/il_S1_summaryleccalc/P39.bin > /dev/null & pid597=$!
tee < fifo/full_correlation/il_S1_summary_P39.idx work/full_correlation/il_S1_summaryaalcalc/P39.idx work/full_correlation/il_S1_summaryleccalc/P39.idx > /dev/null & pid598=$!
tee < fifo/full_correlation/il_S1_summary_P40 fifo/full_correlation/il_S1_eltcalc_P40 fifo/full_correlation/il_S1_summarycalc_P40 fifo/full_correlation/il_S1_pltcalc_P40 work/full_correlation/il_S1_summaryaalcalc/P40.bin work/full_correlation/il_S1_summaryleccalc/P40.bin > /dev/null & pid599=$!
tee < fifo/full_correlation/il_S1_summary_P40.idx work/full_correlation/il_S1_summaryaalcalc/P40.idx work/full_correlation/il_S1_summaryleccalc/P40.idx > /dev/null & pid600=$!

summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P1 < fifo/full_correlation/il_P1 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P2 < fifo/full_correlation/il_P2 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P3 < fifo/full_correlation/il_P3 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P4 < fifo/full_correlation/il_P4 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P5 < fifo/full_correlation/il_P5 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P6 < fifo/full_correlation/il_P6 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P7 < fifo/full_correlation/il_P7 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P8 < fifo/full_correlation/il_P8 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P9 < fifo/full_correlation/il_P9 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P10 < fifo/full_correlation/il_P10 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P11 < fifo/full_correlation/il_P11 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P12 < fifo/full_correlation/il_P12 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P13 < fifo/full_correlation/il_P13 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P14 < fifo/full_correlation/il_P14 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P15 < fifo/full_correlation/il_P15 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P16 < fifo/full_correlation/il_P16 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P17 < fifo/full_correlation/il_P17 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P18 < fifo/full_correlation/il_P18 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P19 < fifo/full_correlation/il_P19 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P20 < fifo/full_correlation/il_P20 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P21 < fifo/full_correlation/il_P21 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P22 < fifo/full_correlation/il_P22 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P23 < fifo/full_correlation/il_P23 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P24 < fifo/full_correlation/il_P24 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P25 < fifo/full_correlation/il_P25 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P26 < fifo/full_correlation/il_P26 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P27 < fifo/full_correlation/il_P27 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P28 < fifo/full_correlation/il_P28 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P29 < fifo/full_correlation/il_P29 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P30 < fifo/full_correlation/il_P30 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P31 < fifo/full_correlation/il_P31 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P32 < fifo/full_correlation/il_P32 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P33 < fifo/full_correlation/il_P33 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P34 < fifo/full_correlation/il_P34 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P35 < fifo/full_correlation/il_P35 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P36 < fifo/full_correlation/il_P36 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P37 < fifo/full_correlation/il_P37 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P38 < fifo/full_correlation/il_P38 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P39 < fifo/full_correlation/il_P39 &
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P40 < fifo/full_correlation/il_P40 &

# --- Do ground up loss computes ---

eltcalc < fifo/full_correlation/gul_S1_eltcalc_P1 > work/full_correlation/kat/gul_S1_eltcalc_P1 & pid601=$!
summarycalctocsv < fifo/full_correlation/gul_S1_summarycalc_P1 > work/full_correlation/kat/gul_S1_summarycalc_P1 & pid602=$!
pltcalc < fifo/full_correlation/gul_S1_pltcalc_P1 > work/full_correlation/kat/gul_S1_pltcalc_P1 & pid603=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P2 > work/full_correlation/kat/gul_S1_eltcalc_P2 & pid604=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P2 > work/full_correlation/kat/gul_S1_summarycalc_P2 & pid605=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P2 > work/full_correlation/kat/gul_S1_pltcalc_P2 & pid606=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P3 > work/full_correlation/kat/gul_S1_eltcalc_P3 & pid607=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P3 > work/full_correlation/kat/gul_S1_summarycalc_P3 & pid608=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P3 > work/full_correlation/kat/gul_S1_pltcalc_P3 & pid609=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P4 > work/full_correlation/kat/gul_S1_eltcalc_P4 & pid610=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P4 > work/full_correlation/kat/gul_S1_summarycalc_P4 & pid611=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P4 > work/full_correlation/kat/gul_S1_pltcalc_P4 & pid612=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P5 > work/full_correlation/kat/gul_S1_eltcalc_P5 & pid613=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P5 > work/full_correlation/kat/gul_S1_summarycalc_P5 & pid614=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P5 > work/full_correlation/kat/gul_S1_pltcalc_P5 & pid615=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P6 > work/full_correlation/kat/gul_S1_eltcalc_P6 & pid616=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P6 > work/full_correlation/kat/gul_S1_summarycalc_P6 & pid617=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P6 > work/full_correlation/kat/gul_S1_pltcalc_P6 & pid618=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P7 > work/full_correlation/kat/gul_S1_eltcalc_P7 & pid619=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P7 > work/full_correlation/kat/gul_S1_summarycalc_P7 & pid620=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P7 > work/full_correlation/kat/gul_S1_pltcalc_P7 & pid621=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P8 > work/full_correlation/kat/gul_S1_eltcalc_P8 & pid622=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P8 > work/full_correlation/kat/gul_S1_summarycalc_P8 & pid623=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P8 > work/full_correlation/kat/gul_S1_pltcalc_P8 & pid624=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P9 > work/full_correlation/kat/gul_S1_eltcalc_P9 & pid625=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P9 > work/full_correlation/kat/gul_S1_summarycalc_P9 & pid626=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P9 > work/full_correlation/kat/gul_S1_pltcalc_P9 & pid627=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P10 > work/full_correlation/kat/gul_S1_eltcalc_P10 & pid628=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P10 > work/full_correlation/kat/gul_S1_summarycalc_P10 & pid629=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P10 > work/full_correlation/kat/gul_S1_pltcalc_P10 & pid630=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P11 > work/full_correlation/kat/gul_S1_eltcalc_P11 & pid631=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P11 > work/full_correlation/kat/gul_S1_summarycalc_P11 & pid632=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P11 > work/full_correlation/kat/gul_S1_pltcalc_P11 & pid633=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P12 > work/full_correlation/kat/gul_S1_eltcalc_P12 & pid634=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P12 > work/full_correlation/kat/gul_S1_summarycalc_P12 & pid635=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P12 > work/full_correlation/kat/gul_S1_pltcalc_P12 & pid636=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P13 > work/full_correlation/kat/gul_S1_eltcalc_P13 & pid637=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P13 > work/full_correlation/kat/gul_S1_summarycalc_P13 & pid638=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P13 > work/full_correlation/kat/gul_S1_pltcalc_P13 & pid639=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P14 > work/full_correlation/kat/gul_S1_eltcalc_P14 & pid640=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P14 > work/full_correlation/kat/gul_S1_summarycalc_P14 & pid641=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P14 > work/full_correlation/kat/gul_S1_pltcalc_P14 & pid642=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P15 > work/full_correlation/kat/gul_S1_eltcalc_P15 & pid643=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P15 > work/full_correlation/kat/gul_S1_summarycalc_P15 & pid644=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P15 > work/full_correlation/kat/gul_S1_pltcalc_P15 & pid645=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P16 > work/full_correlation/kat/gul_S1_eltcalc_P16 & pid646=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P16 > work/full_correlation/kat/gul_S1_summarycalc_P16 & pid647=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P16 > work/full_correlation/kat/gul_S1_pltcalc_P16 & pid648=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P17 > work/full_correlation/kat/gul_S1_eltcalc_P17 & pid649=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P17 > work/full_correlation/kat/gul_S1_summarycalc_P17 & pid650=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P17 > work/full_correlation/kat/gul_S1_pltcalc_P17 & pid651=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P18 > work/full_correlation/kat/gul_S1_eltcalc_P18 & pid652=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P18 > work/full_correlation/kat/gul_S1_summarycalc_P18 & pid653=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P18 > work/full_correlation/kat/gul_S1_pltcalc_P18 & pid654=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P19 > work/full_correlation/kat/gul_S1_eltcalc_P19 & pid655=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P19 > work/full_correlation/kat/gul_S1_summarycalc_P19 & pid656=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P19 > work/full_correlation/kat/gul_S1_pltcalc_P19 & pid657=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P20 > work/full_correlation/kat/gul_S1_eltcalc_P20 & pid658=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P20 > work/full_correlation/kat/gul_S1_summarycalc_P20 & pid659=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P20 > work/full_correlation/kat/gul_S1_pltcalc_P20 & pid660=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P21 > work/full_correlation/kat/gul_S1_eltcalc_P21 & pid661=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P21 > work/full_correlation/kat/gul_S1_summarycalc_P21 & pid662=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P21 > work/full_correlation/kat/gul_S1_pltcalc_P21 & pid663=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P22 > work/full_correlation/kat/gul_S1_eltcalc_P22 & pid664=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P22 > work/full_correlation/kat/gul_S1_summarycalc_P22 & pid665=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P22 > work/full_correlation/kat/gul_S1_pltcalc_P22 & pid666=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P23 > work/full_correlation/kat/gul_S1_eltcalc_P23 & pid667=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P23 > work/full_correlation/kat/gul_S1_summarycalc_P23 & pid668=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P23 > work/full_correlation/kat/gul_S1_pltcalc_P23 & pid669=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P24 > work/full_correlation/kat/gul_S1_eltcalc_P24 & pid670=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P24 > work/full_correlation/kat/gul_S1_summarycalc_P24 & pid671=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P24 > work/full_correlation/kat/gul_S1_pltcalc_P24 & pid672=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P25 > work/full_correlation/kat/gul_S1_eltcalc_P25 & pid673=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P25 > work/full_correlation/kat/gul_S1_summarycalc_P25 & pid674=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P25 > work/full_correlation/kat/gul_S1_pltcalc_P25 & pid675=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P26 > work/full_correlation/kat/gul_S1_eltcalc_P26 & pid676=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P26 > work/full_correlation/kat/gul_S1_summarycalc_P26 & pid677=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P26 > work/full_correlation/kat/gul_S1_pltcalc_P26 & pid678=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P27 > work/full_correlation/kat/gul_S1_eltcalc_P27 & pid679=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P27 > work/full_correlation/kat/gul_S1_summarycalc_P27 & pid680=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P27 > work/full_correlation/kat/gul_S1_pltcalc_P27 & pid681=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P28 > work/full_correlation/kat/gul_S1_eltcalc_P28 & pid682=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P28 > work/full_correlation/kat/gul_S1_summarycalc_P28 & pid683=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P28 > work/full_correlation/kat/gul_S1_pltcalc_P28 & pid684=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P29 > work/full_correlation/kat/gul_S1_eltcalc_P29 & pid685=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P29 > work/full_correlation/kat/gul_S1_summarycalc_P29 & pid686=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P29 > work/full_correlation/kat/gul_S1_pltcalc_P29 & pid687=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P30 > work/full_correlation/kat/gul_S1_eltcalc_P30 & pid688=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P30 > work/full_correlation/kat/gul_S1_summarycalc_P30 & pid689=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P30 > work/full_correlation/kat/gul_S1_pltcalc_P30 & pid690=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P31 > work/full_correlation/kat/gul_S1_eltcalc_P31 & pid691=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P31 > work/full_correlation/kat/gul_S1_summarycalc_P31 & pid692=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P31 > work/full_correlation/kat/gul_S1_pltcalc_P31 & pid693=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P32 > work/full_correlation/kat/gul_S1_eltcalc_P32 & pid694=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P32 > work/full_correlation/kat/gul_S1_summarycalc_P32 & pid695=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P32 > work/full_correlation/kat/gul_S1_pltcalc_P32 & pid696=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P33 > work/full_correlation/kat/gul_S1_eltcalc_P33 & pid697=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P33 > work/full_correlation/kat/gul_S1_summarycalc_P33 & pid698=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P33 > work/full_correlation/kat/gul_S1_pltcalc_P33 & pid699=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P34 > work/full_correlation/kat/gul_S1_eltcalc_P34 & pid700=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P34 > work/full_correlation/kat/gul_S1_summarycalc_P34 & pid701=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P34 > work/full_correlation/kat/gul_S1_pltcalc_P34 & pid702=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P35 > work/full_correlation/kat/gul_S1_eltcalc_P35 & pid703=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P35 > work/full_correlation/kat/gul_S1_summarycalc_P35 & pid704=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P35 > work/full_correlation/kat/gul_S1_pltcalc_P35 & pid705=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P36 > work/full_correlation/kat/gul_S1_eltcalc_P36 & pid706=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P36 > work/full_correlation/kat/gul_S1_summarycalc_P36 & pid707=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P36 > work/full_correlation/kat/gul_S1_pltcalc_P36 & pid708=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P37 > work/full_correlation/kat/gul_S1_eltcalc_P37 & pid709=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P37 > work/full_correlation/kat/gul_S1_summarycalc_P37 & pid710=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P37 > work/full_correlation/kat/gul_S1_pltcalc_P37 & pid711=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P38 > work/full_correlation/kat/gul_S1_eltcalc_P38 & pid712=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P38 > work/full_correlation/kat/gul_S1_summarycalc_P38 & pid713=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P38 > work/full_correlation/kat/gul_S1_pltcalc_P38 & pid714=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P39 > work/full_correlation/kat/gul_S1_eltcalc_P39 & pid715=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P39 > work/full_correlation/kat/gul_S1_summarycalc_P39 & pid716=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P39 > work/full_correlation/kat/gul_S1_pltcalc_P39 & pid717=$!
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P40 > work/full_correlation/kat/gul_S1_eltcalc_P40 & pid718=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P40 > work/full_correlation/kat/gul_S1_summarycalc_P40 & pid719=$!
pltcalc -H < fifo/full_correlation/gul_S1_pltcalc_P40 > work/full_correlation/kat/gul_S1_pltcalc_P40 & pid720=$!


tee < fifo/full_correlation/gul_S1_summary_P1 fifo/full_correlation/gul_S1_eltcalc_P1 fifo/full_correlation/gul_S1_summarycalc_P1 fifo/full_correlation/gul_S1_pltcalc_P1 work/full_correlation/gul_S1_summaryaalcalc/P1.bin work/full_correlation/gul_S1_summaryleccalc/P1.bin > /dev/null & pid721=$!
tee < fifo/full_correlation/gul_S1_summary_P1.idx work/full_correlation/gul_S1_summaryaalcalc/P1.idx work/full_correlation/gul_S1_summaryleccalc/P1.idx > /dev/null & pid722=$!
tee < fifo/full_correlation/gul_S1_summary_P2 fifo/full_correlation/gul_S1_eltcalc_P2 fifo/full_correlation/gul_S1_summarycalc_P2 fifo/full_correlation/gul_S1_pltcalc_P2 work/full_correlation/gul_S1_summaryaalcalc/P2.bin work/full_correlation/gul_S1_summaryleccalc/P2.bin > /dev/null & pid723=$!
tee < fifo/full_correlation/gul_S1_summary_P2.idx work/full_correlation/gul_S1_summaryaalcalc/P2.idx work/full_correlation/gul_S1_summaryleccalc/P2.idx > /dev/null & pid724=$!
tee < fifo/full_correlation/gul_S1_summary_P3 fifo/full_correlation/gul_S1_eltcalc_P3 fifo/full_correlation/gul_S1_summarycalc_P3 fifo/full_correlation/gul_S1_pltcalc_P3 work/full_correlation/gul_S1_summaryaalcalc/P3.bin work/full_correlation/gul_S1_summaryleccalc/P3.bin > /dev/null & pid725=$!
tee < fifo/full_correlation/gul_S1_summary_P3.idx work/full_correlation/gul_S1_summaryaalcalc/P3.idx work/full_correlation/gul_S1_summaryleccalc/P3.idx > /dev/null & pid726=$!
tee < fifo/full_correlation/gul_S1_summary_P4 fifo/full_correlation/gul_S1_eltcalc_P4 fifo/full_correlation/gul_S1_summarycalc_P4 fifo/full_correlation/gul_S1_pltcalc_P4 work/full_correlation/gul_S1_summaryaalcalc/P4.bin work/full_correlation/gul_S1_summaryleccalc/P4.bin > /dev/null & pid727=$!
tee < fifo/full_correlation/gul_S1_summary_P4.idx work/full_correlation/gul_S1_summaryaalcalc/P4.idx work/full_correlation/gul_S1_summaryleccalc/P4.idx > /dev/null & pid728=$!
tee < fifo/full_correlation/gul_S1_summary_P5 fifo/full_correlation/gul_S1_eltcalc_P5 fifo/full_correlation/gul_S1_summarycalc_P5 fifo/full_correlation/gul_S1_pltcalc_P5 work/full_correlation/gul_S1_summaryaalcalc/P5.bin work/full_correlation/gul_S1_summaryleccalc/P5.bin > /dev/null & pid729=$!
tee < fifo/full_correlation/gul_S1_summary_P5.idx work/full_correlation/gul_S1_summaryaalcalc/P5.idx work/full_correlation/gul_S1_summaryleccalc/P5.idx > /dev/null & pid730=$!
tee < fifo/full_correlation/gul_S1_summary_P6 fifo/full_correlation/gul_S1_eltcalc_P6 fifo/full_correlation/gul_S1_summarycalc_P6 fifo/full_correlation/gul_S1_pltcalc_P6 work/full_correlation/gul_S1_summaryaalcalc/P6.bin work/full_correlation/gul_S1_summaryleccalc/P6.bin > /dev/null & pid731=$!
tee < fifo/full_correlation/gul_S1_summary_P6.idx work/full_correlation/gul_S1_summaryaalcalc/P6.idx work/full_correlation/gul_S1_summaryleccalc/P6.idx > /dev/null & pid732=$!
tee < fifo/full_correlation/gul_S1_summary_P7 fifo/full_correlation/gul_S1_eltcalc_P7 fifo/full_correlation/gul_S1_summarycalc_P7 fifo/full_correlation/gul_S1_pltcalc_P7 work/full_correlation/gul_S1_summaryaalcalc/P7.bin work/full_correlation/gul_S1_summaryleccalc/P7.bin > /dev/null & pid733=$!
tee < fifo/full_correlation/gul_S1_summary_P7.idx work/full_correlation/gul_S1_summaryaalcalc/P7.idx work/full_correlation/gul_S1_summaryleccalc/P7.idx > /dev/null & pid734=$!
tee < fifo/full_correlation/gul_S1_summary_P8 fifo/full_correlation/gul_S1_eltcalc_P8 fifo/full_correlation/gul_S1_summarycalc_P8 fifo/full_correlation/gul_S1_pltcalc_P8 work/full_correlation/gul_S1_summaryaalcalc/P8.bin work/full_correlation/gul_S1_summaryleccalc/P8.bin > /dev/null & pid735=$!
tee < fifo/full_correlation/gul_S1_summary_P8.idx work/full_correlation/gul_S1_summaryaalcalc/P8.idx work/full_correlation/gul_S1_summaryleccalc/P8.idx > /dev/null & pid736=$!
tee < fifo/full_correlation/gul_S1_summary_P9 fifo/full_correlation/gul_S1_eltcalc_P9 fifo/full_correlation/gul_S1_summarycalc_P9 fifo/full_correlation/gul_S1_pltcalc_P9 work/full_correlation/gul_S1_summaryaalcalc/P9.bin work/full_correlation/gul_S1_summaryleccalc/P9.bin > /dev/null & pid737=$!
tee < fifo/full_correlation/gul_S1_summary_P9.idx work/full_correlation/gul_S1_summaryaalcalc/P9.idx work/full_correlation/gul_S1_summaryleccalc/P9.idx > /dev/null & pid738=$!
tee < fifo/full_correlation/gul_S1_summary_P10 fifo/full_correlation/gul_S1_eltcalc_P10 fifo/full_correlation/gul_S1_summarycalc_P10 fifo/full_correlation/gul_S1_pltcalc_P10 work/full_correlation/gul_S1_summaryaalcalc/P10.bin work/full_correlation/gul_S1_summaryleccalc/P10.bin > /dev/null & pid739=$!
tee < fifo/full_correlation/gul_S1_summary_P10.idx work/full_correlation/gul_S1_summaryaalcalc/P10.idx work/full_correlation/gul_S1_summaryleccalc/P10.idx > /dev/null & pid740=$!
tee < fifo/full_correlation/gul_S1_summary_P11 fifo/full_correlation/gul_S1_eltcalc_P11 fifo/full_correlation/gul_S1_summarycalc_P11 fifo/full_correlation/gul_S1_pltcalc_P11 work/full_correlation/gul_S1_summaryaalcalc/P11.bin work/full_correlation/gul_S1_summaryleccalc/P11.bin > /dev/null & pid741=$!
tee < fifo/full_correlation/gul_S1_summary_P11.idx work/full_correlation/gul_S1_summaryaalcalc/P11.idx work/full_correlation/gul_S1_summaryleccalc/P11.idx > /dev/null & pid742=$!
tee < fifo/full_correlation/gul_S1_summary_P12 fifo/full_correlation/gul_S1_eltcalc_P12 fifo/full_correlation/gul_S1_summarycalc_P12 fifo/full_correlation/gul_S1_pltcalc_P12 work/full_correlation/gul_S1_summaryaalcalc/P12.bin work/full_correlation/gul_S1_summaryleccalc/P12.bin > /dev/null & pid743=$!
tee < fifo/full_correlation/gul_S1_summary_P12.idx work/full_correlation/gul_S1_summaryaalcalc/P12.idx work/full_correlation/gul_S1_summaryleccalc/P12.idx > /dev/null & pid744=$!
tee < fifo/full_correlation/gul_S1_summary_P13 fifo/full_correlation/gul_S1_eltcalc_P13 fifo/full_correlation/gul_S1_summarycalc_P13 fifo/full_correlation/gul_S1_pltcalc_P13 work/full_correlation/gul_S1_summaryaalcalc/P13.bin work/full_correlation/gul_S1_summaryleccalc/P13.bin > /dev/null & pid745=$!
tee < fifo/full_correlation/gul_S1_summary_P13.idx work/full_correlation/gul_S1_summaryaalcalc/P13.idx work/full_correlation/gul_S1_summaryleccalc/P13.idx > /dev/null & pid746=$!
tee < fifo/full_correlation/gul_S1_summary_P14 fifo/full_correlation/gul_S1_eltcalc_P14 fifo/full_correlation/gul_S1_summarycalc_P14 fifo/full_correlation/gul_S1_pltcalc_P14 work/full_correlation/gul_S1_summaryaalcalc/P14.bin work/full_correlation/gul_S1_summaryleccalc/P14.bin > /dev/null & pid747=$!
tee < fifo/full_correlation/gul_S1_summary_P14.idx work/full_correlation/gul_S1_summaryaalcalc/P14.idx work/full_correlation/gul_S1_summaryleccalc/P14.idx > /dev/null & pid748=$!
tee < fifo/full_correlation/gul_S1_summary_P15 fifo/full_correlation/gul_S1_eltcalc_P15 fifo/full_correlation/gul_S1_summarycalc_P15 fifo/full_correlation/gul_S1_pltcalc_P15 work/full_correlation/gul_S1_summaryaalcalc/P15.bin work/full_correlation/gul_S1_summaryleccalc/P15.bin > /dev/null & pid749=$!
tee < fifo/full_correlation/gul_S1_summary_P15.idx work/full_correlation/gul_S1_summaryaalcalc/P15.idx work/full_correlation/gul_S1_summaryleccalc/P15.idx > /dev/null & pid750=$!
tee < fifo/full_correlation/gul_S1_summary_P16 fifo/full_correlation/gul_S1_eltcalc_P16 fifo/full_correlation/gul_S1_summarycalc_P16 fifo/full_correlation/gul_S1_pltcalc_P16 work/full_correlation/gul_S1_summaryaalcalc/P16.bin work/full_correlation/gul_S1_summaryleccalc/P16.bin > /dev/null & pid751=$!
tee < fifo/full_correlation/gul_S1_summary_P16.idx work/full_correlation/gul_S1_summaryaalcalc/P16.idx work/full_correlation/gul_S1_summaryleccalc/P16.idx > /dev/null & pid752=$!
tee < fifo/full_correlation/gul_S1_summary_P17 fifo/full_correlation/gul_S1_eltcalc_P17 fifo/full_correlation/gul_S1_summarycalc_P17 fifo/full_correlation/gul_S1_pltcalc_P17 work/full_correlation/gul_S1_summaryaalcalc/P17.bin work/full_correlation/gul_S1_summaryleccalc/P17.bin > /dev/null & pid753=$!
tee < fifo/full_correlation/gul_S1_summary_P17.idx work/full_correlation/gul_S1_summaryaalcalc/P17.idx work/full_correlation/gul_S1_summaryleccalc/P17.idx > /dev/null & pid754=$!
tee < fifo/full_correlation/gul_S1_summary_P18 fifo/full_correlation/gul_S1_eltcalc_P18 fifo/full_correlation/gul_S1_summarycalc_P18 fifo/full_correlation/gul_S1_pltcalc_P18 work/full_correlation/gul_S1_summaryaalcalc/P18.bin work/full_correlation/gul_S1_summaryleccalc/P18.bin > /dev/null & pid755=$!
tee < fifo/full_correlation/gul_S1_summary_P18.idx work/full_correlation/gul_S1_summaryaalcalc/P18.idx work/full_correlation/gul_S1_summaryleccalc/P18.idx > /dev/null & pid756=$!
tee < fifo/full_correlation/gul_S1_summary_P19 fifo/full_correlation/gul_S1_eltcalc_P19 fifo/full_correlation/gul_S1_summarycalc_P19 fifo/full_correlation/gul_S1_pltcalc_P19 work/full_correlation/gul_S1_summaryaalcalc/P19.bin work/full_correlation/gul_S1_summaryleccalc/P19.bin > /dev/null & pid757=$!
tee < fifo/full_correlation/gul_S1_summary_P19.idx work/full_correlation/gul_S1_summaryaalcalc/P19.idx work/full_correlation/gul_S1_summaryleccalc/P19.idx > /dev/null & pid758=$!
tee < fifo/full_correlation/gul_S1_summary_P20 fifo/full_correlation/gul_S1_eltcalc_P20 fifo/full_correlation/gul_S1_summarycalc_P20 fifo/full_correlation/gul_S1_pltcalc_P20 work/full_correlation/gul_S1_summaryaalcalc/P20.bin work/full_correlation/gul_S1_summaryleccalc/P20.bin > /dev/null & pid759=$!
tee < fifo/full_correlation/gul_S1_summary_P20.idx work/full_correlation/gul_S1_summaryaalcalc/P20.idx work/full_correlation/gul_S1_summaryleccalc/P20.idx > /dev/null & pid760=$!
tee < fifo/full_correlation/gul_S1_summary_P21 fifo/full_correlation/gul_S1_eltcalc_P21 fifo/full_correlation/gul_S1_summarycalc_P21 fifo/full_correlation/gul_S1_pltcalc_P21 work/full_correlation/gul_S1_summaryaalcalc/P21.bin work/full_correlation/gul_S1_summaryleccalc/P21.bin > /dev/null & pid761=$!
tee < fifo/full_correlation/gul_S1_summary_P21.idx work/full_correlation/gul_S1_summaryaalcalc/P21.idx work/full_correlation/gul_S1_summaryleccalc/P21.idx > /dev/null & pid762=$!
tee < fifo/full_correlation/gul_S1_summary_P22 fifo/full_correlation/gul_S1_eltcalc_P22 fifo/full_correlation/gul_S1_summarycalc_P22 fifo/full_correlation/gul_S1_pltcalc_P22 work/full_correlation/gul_S1_summaryaalcalc/P22.bin work/full_correlation/gul_S1_summaryleccalc/P22.bin > /dev/null & pid763=$!
tee < fifo/full_correlation/gul_S1_summary_P22.idx work/full_correlation/gul_S1_summaryaalcalc/P22.idx work/full_correlation/gul_S1_summaryleccalc/P22.idx > /dev/null & pid764=$!
tee < fifo/full_correlation/gul_S1_summary_P23 fifo/full_correlation/gul_S1_eltcalc_P23 fifo/full_correlation/gul_S1_summarycalc_P23 fifo/full_correlation/gul_S1_pltcalc_P23 work/full_correlation/gul_S1_summaryaalcalc/P23.bin work/full_correlation/gul_S1_summaryleccalc/P23.bin > /dev/null & pid765=$!
tee < fifo/full_correlation/gul_S1_summary_P23.idx work/full_correlation/gul_S1_summaryaalcalc/P23.idx work/full_correlation/gul_S1_summaryleccalc/P23.idx > /dev/null & pid766=$!
tee < fifo/full_correlation/gul_S1_summary_P24 fifo/full_correlation/gul_S1_eltcalc_P24 fifo/full_correlation/gul_S1_summarycalc_P24 fifo/full_correlation/gul_S1_pltcalc_P24 work/full_correlation/gul_S1_summaryaalcalc/P24.bin work/full_correlation/gul_S1_summaryleccalc/P24.bin > /dev/null & pid767=$!
tee < fifo/full_correlation/gul_S1_summary_P24.idx work/full_correlation/gul_S1_summaryaalcalc/P24.idx work/full_correlation/gul_S1_summaryleccalc/P24.idx > /dev/null & pid768=$!
tee < fifo/full_correlation/gul_S1_summary_P25 fifo/full_correlation/gul_S1_eltcalc_P25 fifo/full_correlation/gul_S1_summarycalc_P25 fifo/full_correlation/gul_S1_pltcalc_P25 work/full_correlation/gul_S1_summaryaalcalc/P25.bin work/full_correlation/gul_S1_summaryleccalc/P25.bin > /dev/null & pid769=$!
tee < fifo/full_correlation/gul_S1_summary_P25.idx work/full_correlation/gul_S1_summaryaalcalc/P25.idx work/full_correlation/gul_S1_summaryleccalc/P25.idx > /dev/null & pid770=$!
tee < fifo/full_correlation/gul_S1_summary_P26 fifo/full_correlation/gul_S1_eltcalc_P26 fifo/full_correlation/gul_S1_summarycalc_P26 fifo/full_correlation/gul_S1_pltcalc_P26 work/full_correlation/gul_S1_summaryaalcalc/P26.bin work/full_correlation/gul_S1_summaryleccalc/P26.bin > /dev/null & pid771=$!
tee < fifo/full_correlation/gul_S1_summary_P26.idx work/full_correlation/gul_S1_summaryaalcalc/P26.idx work/full_correlation/gul_S1_summaryleccalc/P26.idx > /dev/null & pid772=$!
tee < fifo/full_correlation/gul_S1_summary_P27 fifo/full_correlation/gul_S1_eltcalc_P27 fifo/full_correlation/gul_S1_summarycalc_P27 fifo/full_correlation/gul_S1_pltcalc_P27 work/full_correlation/gul_S1_summaryaalcalc/P27.bin work/full_correlation/gul_S1_summaryleccalc/P27.bin > /dev/null & pid773=$!
tee < fifo/full_correlation/gul_S1_summary_P27.idx work/full_correlation/gul_S1_summaryaalcalc/P27.idx work/full_correlation/gul_S1_summaryleccalc/P27.idx > /dev/null & pid774=$!
tee < fifo/full_correlation/gul_S1_summary_P28 fifo/full_correlation/gul_S1_eltcalc_P28 fifo/full_correlation/gul_S1_summarycalc_P28 fifo/full_correlation/gul_S1_pltcalc_P28 work/full_correlation/gul_S1_summaryaalcalc/P28.bin work/full_correlation/gul_S1_summaryleccalc/P28.bin > /dev/null & pid775=$!
tee < fifo/full_correlation/gul_S1_summary_P28.idx work/full_correlation/gul_S1_summaryaalcalc/P28.idx work/full_correlation/gul_S1_summaryleccalc/P28.idx > /dev/null & pid776=$!
tee < fifo/full_correlation/gul_S1_summary_P29 fifo/full_correlation/gul_S1_eltcalc_P29 fifo/full_correlation/gul_S1_summarycalc_P29 fifo/full_correlation/gul_S1_pltcalc_P29 work/full_correlation/gul_S1_summaryaalcalc/P29.bin work/full_correlation/gul_S1_summaryleccalc/P29.bin > /dev/null & pid777=$!
tee < fifo/full_correlation/gul_S1_summary_P29.idx work/full_correlation/gul_S1_summaryaalcalc/P29.idx work/full_correlation/gul_S1_summaryleccalc/P29.idx > /dev/null & pid778=$!
tee < fifo/full_correlation/gul_S1_summary_P30 fifo/full_correlation/gul_S1_eltcalc_P30 fifo/full_correlation/gul_S1_summarycalc_P30 fifo/full_correlation/gul_S1_pltcalc_P30 work/full_correlation/gul_S1_summaryaalcalc/P30.bin work/full_correlation/gul_S1_summaryleccalc/P30.bin > /dev/null & pid779=$!
tee < fifo/full_correlation/gul_S1_summary_P30.idx work/full_correlation/gul_S1_summaryaalcalc/P30.idx work/full_correlation/gul_S1_summaryleccalc/P30.idx > /dev/null & pid780=$!
tee < fifo/full_correlation/gul_S1_summary_P31 fifo/full_correlation/gul_S1_eltcalc_P31 fifo/full_correlation/gul_S1_summarycalc_P31 fifo/full_correlation/gul_S1_pltcalc_P31 work/full_correlation/gul_S1_summaryaalcalc/P31.bin work/full_correlation/gul_S1_summaryleccalc/P31.bin > /dev/null & pid781=$!
tee < fifo/full_correlation/gul_S1_summary_P31.idx work/full_correlation/gul_S1_summaryaalcalc/P31.idx work/full_correlation/gul_S1_summaryleccalc/P31.idx > /dev/null & pid782=$!
tee < fifo/full_correlation/gul_S1_summary_P32 fifo/full_correlation/gul_S1_eltcalc_P32 fifo/full_correlation/gul_S1_summarycalc_P32 fifo/full_correlation/gul_S1_pltcalc_P32 work/full_correlation/gul_S1_summaryaalcalc/P32.bin work/full_correlation/gul_S1_summaryleccalc/P32.bin > /dev/null & pid783=$!
tee < fifo/full_correlation/gul_S1_summary_P32.idx work/full_correlation/gul_S1_summaryaalcalc/P32.idx work/full_correlation/gul_S1_summaryleccalc/P32.idx > /dev/null & pid784=$!
tee < fifo/full_correlation/gul_S1_summary_P33 fifo/full_correlation/gul_S1_eltcalc_P33 fifo/full_correlation/gul_S1_summarycalc_P33 fifo/full_correlation/gul_S1_pltcalc_P33 work/full_correlation/gul_S1_summaryaalcalc/P33.bin work/full_correlation/gul_S1_summaryleccalc/P33.bin > /dev/null & pid785=$!
tee < fifo/full_correlation/gul_S1_summary_P33.idx work/full_correlation/gul_S1_summaryaalcalc/P33.idx work/full_correlation/gul_S1_summaryleccalc/P33.idx > /dev/null & pid786=$!
tee < fifo/full_correlation/gul_S1_summary_P34 fifo/full_correlation/gul_S1_eltcalc_P34 fifo/full_correlation/gul_S1_summarycalc_P34 fifo/full_correlation/gul_S1_pltcalc_P34 work/full_correlation/gul_S1_summaryaalcalc/P34.bin work/full_correlation/gul_S1_summaryleccalc/P34.bin > /dev/null & pid787=$!
tee < fifo/full_correlation/gul_S1_summary_P34.idx work/full_correlation/gul_S1_summaryaalcalc/P34.idx work/full_correlation/gul_S1_summaryleccalc/P34.idx > /dev/null & pid788=$!
tee < fifo/full_correlation/gul_S1_summary_P35 fifo/full_correlation/gul_S1_eltcalc_P35 fifo/full_correlation/gul_S1_summarycalc_P35 fifo/full_correlation/gul_S1_pltcalc_P35 work/full_correlation/gul_S1_summaryaalcalc/P35.bin work/full_correlation/gul_S1_summaryleccalc/P35.bin > /dev/null & pid789=$!
tee < fifo/full_correlation/gul_S1_summary_P35.idx work/full_correlation/gul_S1_summaryaalcalc/P35.idx work/full_correlation/gul_S1_summaryleccalc/P35.idx > /dev/null & pid790=$!
tee < fifo/full_correlation/gul_S1_summary_P36 fifo/full_correlation/gul_S1_eltcalc_P36 fifo/full_correlation/gul_S1_summarycalc_P36 fifo/full_correlation/gul_S1_pltcalc_P36 work/full_correlation/gul_S1_summaryaalcalc/P36.bin work/full_correlation/gul_S1_summaryleccalc/P36.bin > /dev/null & pid791=$!
tee < fifo/full_correlation/gul_S1_summary_P36.idx work/full_correlation/gul_S1_summaryaalcalc/P36.idx work/full_correlation/gul_S1_summaryleccalc/P36.idx > /dev/null & pid792=$!
tee < fifo/full_correlation/gul_S1_summary_P37 fifo/full_correlation/gul_S1_eltcalc_P37 fifo/full_correlation/gul_S1_summarycalc_P37 fifo/full_correlation/gul_S1_pltcalc_P37 work/full_correlation/gul_S1_summaryaalcalc/P37.bin work/full_correlation/gul_S1_summaryleccalc/P37.bin > /dev/null & pid793=$!
tee < fifo/full_correlation/gul_S1_summary_P37.idx work/full_correlation/gul_S1_summaryaalcalc/P37.idx work/full_correlation/gul_S1_summaryleccalc/P37.idx > /dev/null & pid794=$!
tee < fifo/full_correlation/gul_S1_summary_P38 fifo/full_correlation/gul_S1_eltcalc_P38 fifo/full_correlation/gul_S1_summarycalc_P38 fifo/full_correlation/gul_S1_pltcalc_P38 work/full_correlation/gul_S1_summaryaalcalc/P38.bin work/full_correlation/gul_S1_summaryleccalc/P38.bin > /dev/null & pid795=$!
tee < fifo/full_correlation/gul_S1_summary_P38.idx work/full_correlation/gul_S1_summaryaalcalc/P38.idx work/full_correlation/gul_S1_summaryleccalc/P38.idx > /dev/null & pid796=$!
tee < fifo/full_correlation/gul_S1_summary_P39 fifo/full_correlation/gul_S1_eltcalc_P39 fifo/full_correlation/gul_S1_summarycalc_P39 fifo/full_correlation/gul_S1_pltcalc_P39 work/full_correlation/gul_S1_summaryaalcalc/P39.bin work/full_correlation/gul_S1_summaryleccalc/P39.bin > /dev/null & pid797=$!
tee < fifo/full_correlation/gul_S1_summary_P39.idx work/full_correlation/gul_S1_summaryaalcalc/P39.idx work/full_correlation/gul_S1_summaryleccalc/P39.idx > /dev/null & pid798=$!
tee < fifo/full_correlation/gul_S1_summary_P40 fifo/full_correlation/gul_S1_eltcalc_P40 fifo/full_correlation/gul_S1_summarycalc_P40 fifo/full_correlation/gul_S1_pltcalc_P40 work/full_correlation/gul_S1_summaryaalcalc/P40.bin work/full_correlation/gul_S1_summaryleccalc/P40.bin > /dev/null & pid799=$!
tee < fifo/full_correlation/gul_S1_summary_P40.idx work/full_correlation/gul_S1_summaryaalcalc/P40.idx work/full_correlation/gul_S1_summaryleccalc/P40.idx > /dev/null & pid800=$!

summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P1 < fifo/full_correlation/gul_P1 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P2 < fifo/full_correlation/gul_P2 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P3 < fifo/full_correlation/gul_P3 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P4 < fifo/full_correlation/gul_P4 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P5 < fifo/full_correlation/gul_P5 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P6 < fifo/full_correlation/gul_P6 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P7 < fifo/full_correlation/gul_P7 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P8 < fifo/full_correlation/gul_P8 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P9 < fifo/full_correlation/gul_P9 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P10 < fifo/full_correlation/gul_P10 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P11 < fifo/full_correlation/gul_P11 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P12 < fifo/full_correlation/gul_P12 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P13 < fifo/full_correlation/gul_P13 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P14 < fifo/full_correlation/gul_P14 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P15 < fifo/full_correlation/gul_P15 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P16 < fifo/full_correlation/gul_P16 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P17 < fifo/full_correlation/gul_P17 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P18 < fifo/full_correlation/gul_P18 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P19 < fifo/full_correlation/gul_P19 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P20 < fifo/full_correlation/gul_P20 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P21 < fifo/full_correlation/gul_P21 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P22 < fifo/full_correlation/gul_P22 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P23 < fifo/full_correlation/gul_P23 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P24 < fifo/full_correlation/gul_P24 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P25 < fifo/full_correlation/gul_P25 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P26 < fifo/full_correlation/gul_P26 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P27 < fifo/full_correlation/gul_P27 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P28 < fifo/full_correlation/gul_P28 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P29 < fifo/full_correlation/gul_P29 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P30 < fifo/full_correlation/gul_P30 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P31 < fifo/full_correlation/gul_P31 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P32 < fifo/full_correlation/gul_P32 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P33 < fifo/full_correlation/gul_P33 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P34 < fifo/full_correlation/gul_P34 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P35 < fifo/full_correlation/gul_P35 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P36 < fifo/full_correlation/gul_P36 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P37 < fifo/full_correlation/gul_P37 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P38 < fifo/full_correlation/gul_P38 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P39 < fifo/full_correlation/gul_P39 &
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P40 < fifo/full_correlation/gul_P40 &

tee < fifo/full_correlation/gul_fc_P1 fifo/full_correlation/gul_P1  | fmcalc -a2 > fifo/full_correlation/il_P1  &
tee < fifo/full_correlation/gul_fc_P2 fifo/full_correlation/gul_P2  | fmcalc -a2 > fifo/full_correlation/il_P2  &
tee < fifo/full_correlation/gul_fc_P3 fifo/full_correlation/gul_P3  | fmcalc -a2 > fifo/full_correlation/il_P3  &
tee < fifo/full_correlation/gul_fc_P4 fifo/full_correlation/gul_P4  | fmcalc -a2 > fifo/full_correlation/il_P4  &
tee < fifo/full_correlation/gul_fc_P5 fifo/full_correlation/gul_P5  | fmcalc -a2 > fifo/full_correlation/il_P5  &
tee < fifo/full_correlation/gul_fc_P6 fifo/full_correlation/gul_P6  | fmcalc -a2 > fifo/full_correlation/il_P6  &
tee < fifo/full_correlation/gul_fc_P7 fifo/full_correlation/gul_P7  | fmcalc -a2 > fifo/full_correlation/il_P7  &
tee < fifo/full_correlation/gul_fc_P8 fifo/full_correlation/gul_P8  | fmcalc -a2 > fifo/full_correlation/il_P8  &
tee < fifo/full_correlation/gul_fc_P9 fifo/full_correlation/gul_P9  | fmcalc -a2 > fifo/full_correlation/il_P9  &
tee < fifo/full_correlation/gul_fc_P10 fifo/full_correlation/gul_P10  | fmcalc -a2 > fifo/full_correlation/il_P10  &
tee < fifo/full_correlation/gul_fc_P11 fifo/full_correlation/gul_P11  | fmcalc -a2 > fifo/full_correlation/il_P11  &
tee < fifo/full_correlation/gul_fc_P12 fifo/full_correlation/gul_P12  | fmcalc -a2 > fifo/full_correlation/il_P12  &
tee < fifo/full_correlation/gul_fc_P13 fifo/full_correlation/gul_P13  | fmcalc -a2 > fifo/full_correlation/il_P13  &
tee < fifo/full_correlation/gul_fc_P14 fifo/full_correlation/gul_P14  | fmcalc -a2 > fifo/full_correlation/il_P14  &
tee < fifo/full_correlation/gul_fc_P15 fifo/full_correlation/gul_P15  | fmcalc -a2 > fifo/full_correlation/il_P15  &
tee < fifo/full_correlation/gul_fc_P16 fifo/full_correlation/gul_P16  | fmcalc -a2 > fifo/full_correlation/il_P16  &
tee < fifo/full_correlation/gul_fc_P17 fifo/full_correlation/gul_P17  | fmcalc -a2 > fifo/full_correlation/il_P17  &
tee < fifo/full_correlation/gul_fc_P18 fifo/full_correlation/gul_P18  | fmcalc -a2 > fifo/full_correlation/il_P18  &
tee < fifo/full_correlation/gul_fc_P19 fifo/full_correlation/gul_P19  | fmcalc -a2 > fifo/full_correlation/il_P19  &
tee < fifo/full_correlation/gul_fc_P20 fifo/full_correlation/gul_P20  | fmcalc -a2 > fifo/full_correlation/il_P20  &
tee < fifo/full_correlation/gul_fc_P21 fifo/full_correlation/gul_P21  | fmcalc -a2 > fifo/full_correlation/il_P21  &
tee < fifo/full_correlation/gul_fc_P22 fifo/full_correlation/gul_P22  | fmcalc -a2 > fifo/full_correlation/il_P22  &
tee < fifo/full_correlation/gul_fc_P23 fifo/full_correlation/gul_P23  | fmcalc -a2 > fifo/full_correlation/il_P23  &
tee < fifo/full_correlation/gul_fc_P24 fifo/full_correlation/gul_P24  | fmcalc -a2 > fifo/full_correlation/il_P24  &
tee < fifo/full_correlation/gul_fc_P25 fifo/full_correlation/gul_P25  | fmcalc -a2 > fifo/full_correlation/il_P25  &
tee < fifo/full_correlation/gul_fc_P26 fifo/full_correlation/gul_P26  | fmcalc -a2 > fifo/full_correlation/il_P26  &
tee < fifo/full_correlation/gul_fc_P27 fifo/full_correlation/gul_P27  | fmcalc -a2 > fifo/full_correlation/il_P27  &
tee < fifo/full_correlation/gul_fc_P28 fifo/full_correlation/gul_P28  | fmcalc -a2 > fifo/full_correlation/il_P28  &
tee < fifo/full_correlation/gul_fc_P29 fifo/full_correlation/gul_P29  | fmcalc -a2 > fifo/full_correlation/il_P29  &
tee < fifo/full_correlation/gul_fc_P30 fifo/full_correlation/gul_P30  | fmcalc -a2 > fifo/full_correlation/il_P30  &
tee < fifo/full_correlation/gul_fc_P31 fifo/full_correlation/gul_P31  | fmcalc -a2 > fifo/full_correlation/il_P31  &
tee < fifo/full_correlation/gul_fc_P32 fifo/full_correlation/gul_P32  | fmcalc -a2 > fifo/full_correlation/il_P32  &
tee < fifo/full_correlation/gul_fc_P33 fifo/full_correlation/gul_P33  | fmcalc -a2 > fifo/full_correlation/il_P33  &
tee < fifo/full_correlation/gul_fc_P34 fifo/full_correlation/gul_P34  | fmcalc -a2 > fifo/full_correlation/il_P34  &
tee < fifo/full_correlation/gul_fc_P35 fifo/full_correlation/gul_P35  | fmcalc -a2 > fifo/full_correlation/il_P35  &
tee < fifo/full_correlation/gul_fc_P36 fifo/full_correlation/gul_P36  | fmcalc -a2 > fifo/full_correlation/il_P36  &
tee < fifo/full_correlation/gul_fc_P37 fifo/full_correlation/gul_P37  | fmcalc -a2 > fifo/full_correlation/il_P37  &
tee < fifo/full_correlation/gul_fc_P38 fifo/full_correlation/gul_P38  | fmcalc -a2 > fifo/full_correlation/il_P38  &
tee < fifo/full_correlation/gul_fc_P39 fifo/full_correlation/gul_P39  | fmcalc -a2 > fifo/full_correlation/il_P39  &
tee < fifo/full_correlation/gul_fc_P40 fifo/full_correlation/gul_P40  | fmcalc -a2 > fifo/full_correlation/il_P40  &
eve 1 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P1 -a1 -i - | tee fifo/gul_P1 | fmcalc -a2 > fifo/il_P1  &
eve 2 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P2 -a1 -i - | tee fifo/gul_P2 | fmcalc -a2 > fifo/il_P2  &
eve 3 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P3 -a1 -i - | tee fifo/gul_P3 | fmcalc -a2 > fifo/il_P3  &
eve 4 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P4 -a1 -i - | tee fifo/gul_P4 | fmcalc -a2 > fifo/il_P4  &
eve 5 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P5 -a1 -i - | tee fifo/gul_P5 | fmcalc -a2 > fifo/il_P5  &
eve 6 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P6 -a1 -i - | tee fifo/gul_P6 | fmcalc -a2 > fifo/il_P6  &
eve 7 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P7 -a1 -i - | tee fifo/gul_P7 | fmcalc -a2 > fifo/il_P7  &
eve 8 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P8 -a1 -i - | tee fifo/gul_P8 | fmcalc -a2 > fifo/il_P8  &
eve 9 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P9 -a1 -i - | tee fifo/gul_P9 | fmcalc -a2 > fifo/il_P9  &
eve 10 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P10 -a1 -i - | tee fifo/gul_P10 | fmcalc -a2 > fifo/il_P10  &
eve 11 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P11 -a1 -i - | tee fifo/gul_P11 | fmcalc -a2 > fifo/il_P11  &
eve 12 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P12 -a1 -i - | tee fifo/gul_P12 | fmcalc -a2 > fifo/il_P12  &
eve 13 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P13 -a1 -i - | tee fifo/gul_P13 | fmcalc -a2 > fifo/il_P13  &
eve 14 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P14 -a1 -i - | tee fifo/gul_P14 | fmcalc -a2 > fifo/il_P14  &
eve 15 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P15 -a1 -i - | tee fifo/gul_P15 | fmcalc -a2 > fifo/il_P15  &
eve 16 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P16 -a1 -i - | tee fifo/gul_P16 | fmcalc -a2 > fifo/il_P16  &
eve 17 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P17 -a1 -i - | tee fifo/gul_P17 | fmcalc -a2 > fifo/il_P17  &
eve 18 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P18 -a1 -i - | tee fifo/gul_P18 | fmcalc -a2 > fifo/il_P18  &
eve 19 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P19 -a1 -i - | tee fifo/gul_P19 | fmcalc -a2 > fifo/il_P19  &
eve 20 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P20 -a1 -i - | tee fifo/gul_P20 | fmcalc -a2 > fifo/il_P20  &
eve 21 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P21 -a1 -i - | tee fifo/gul_P21 | fmcalc -a2 > fifo/il_P21  &
eve 22 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P22 -a1 -i - | tee fifo/gul_P22 | fmcalc -a2 > fifo/il_P22  &
eve 23 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P23 -a1 -i - | tee fifo/gul_P23 | fmcalc -a2 > fifo/il_P23  &
eve 24 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P24 -a1 -i - | tee fifo/gul_P24 | fmcalc -a2 > fifo/il_P24  &
eve 25 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P25 -a1 -i - | tee fifo/gul_P25 | fmcalc -a2 > fifo/il_P25  &
eve 26 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P26 -a1 -i - | tee fifo/gul_P26 | fmcalc -a2 > fifo/il_P26  &
eve 27 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P27 -a1 -i - | tee fifo/gul_P27 | fmcalc -a2 > fifo/il_P27  &
eve 28 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P28 -a1 -i - | tee fifo/gul_P28 | fmcalc -a2 > fifo/il_P28  &
eve 29 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P29 -a1 -i - | tee fifo/gul_P29 | fmcalc -a2 > fifo/il_P29  &
eve 30 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P30 -a1 -i - | tee fifo/gul_P30 | fmcalc -a2 > fifo/il_P30  &
eve 31 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P31 -a1 -i - | tee fifo/gul_P31 | fmcalc -a2 > fifo/il_P31  &
eve 32 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P32 -a1 -i - | tee fifo/gul_P32 | fmcalc -a2 > fifo/il_P32  &
eve 33 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P33 -a1 -i - | tee fifo/gul_P33 | fmcalc -a2 > fifo/il_P33  &
eve 34 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P34 -a1 -i - | tee fifo/gul_P34 | fmcalc -a2 > fifo/il_P34  &
eve 35 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P35 -a1 -i - | tee fifo/gul_P35 | fmcalc -a2 > fifo/il_P35  &
eve 36 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P36 -a1 -i - | tee fifo/gul_P36 | fmcalc -a2 > fifo/il_P36  &
eve 37 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P37 -a1 -i - | tee fifo/gul_P37 | fmcalc -a2 > fifo/il_P37  &
eve 38 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P38 -a1 -i - | tee fifo/gul_P38 | fmcalc -a2 > fifo/il_P38  &
eve 39 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P39 -a1 -i - | tee fifo/gul_P39 | fmcalc -a2 > fifo/il_P39  &
eve 40 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P40 -a1 -i - | tee fifo/gul_P40 | fmcalc -a2 > fifo/il_P40  &

wait $pid1 $pid2 $pid3 $pid4 $pid5 $pid6 $pid7 $pid8 $pid9 $pid10 $pid11 $pid12 $pid13 $pid14 $pid15 $pid16 $pid17 $pid18 $pid19 $pid20 $pid21 $pid22 $pid23 $pid24 $pid25 $pid26 $pid27 $pid28 $pid29 $pid30 $pid31 $pid32 $pid33 $pid34 $pid35 $pid36 $pid37 $pid38 $pid39 $pid40 $pid41 $pid42 $pid43 $pid44 $pid45 $pid46 $pid47 $pid48 $pid49 $pid50 $pid51 $pid52 $pid53 $pid54 $pid55 $pid56 $pid57 $pid58 $pid59 $pid60 $pid61 $pid62 $pid63 $pid64 $pid65 $pid66 $pid67 $pid68 $pid69 $pid70 $pid71 $pid72 $pid73 $pid74 $pid75 $pid76 $pid77 $pid78 $pid79 $pid80 $pid81 $pid82 $pid83 $pid84 $pid85 $pid86 $pid87 $pid88 $pid89 $pid90 $pid91 $pid92 $pid93 $pid94 $pid95 $pid96 $pid97 $pid98 $pid99 $pid100 $pid101 $pid102 $pid103 $pid104 $pid105 $pid106 $pid107 $pid108 $pid109 $pid110 $pid111 $pid112 $pid113 $pid114 $pid115 $pid116 $pid117 $pid118 $pid119 $pid120 $pid121 $pid122 $pid123 $pid124 $pid125 $pid126 $pid127 $pid128 $pid129 $pid130 $pid131 $pid132 $pid133 $pid134 $pid135 $pid136 $pid137 $pid138 $pid139 $pid140 $pid141 $pid142 $pid143 $pid144 $pid145 $pid146 $pid147 $pid148 $pid149 $pid150 $pid151 $pid152 $pid153 $pid154 $pid155 $pid156 $pid157 $pid158 $pid159 $pid160 $pid161 $pid162 $pid163 $pid164 $pid165 $pid166 $pid167 $pid168 $pid169 $pid170 $pid171 $pid172 $pid173 $pid174 $pid175 $pid176 $pid177 $pid178 $pid179 $pid180 $pid181 $pid182 $pid183 $pid184 $pid185 $pid186 $pid187 $pid188 $pid189 $pid190 $pid191 $pid192 $pid193 $pid194 $pid195 $pid196 $pid197 $pid198 $pid199 $pid200 $pid201 $pid202 $pid203 $pid204 $pid205 $pid206 $pid207 $pid208 $pid209 $pid210 $pid211 $pid212 $pid213 $pid214 $pid215 $pid216 $pid217 $pid218 $pid219 $pid220 $pid221 $pid222 $pid223 $pid224 $pid225 $pid226 $pid227 $pid228 $pid229 $pid230 $pid231 $pid232 $pid233 $pid234 $pid235 $pid236 $pid237 $pid238 $pid239 $pid240 $pid241 $pid242 $pid243 $pid244 $pid245 $pid246 $pid247 $pid248 $pid249 $pid250 $pid251 $pid252 $pid253 $pid254 $pid255 $pid256 $pid257 $pid258 $pid259 $pid260 $pid261 $pid262 $pid263 $pid264 $pid265 $pid266 $pid267 $pid268 $pid269 $pid270 $pid271 $pid272 $pid273 $pid274 $pid275 $pid276 $pid277 $pid278 $pid279 $pid280 $pid281 $pid282 $pid283 $pid284 $pid285 $pid286 $pid287 $pid288 $pid289 $pid290 $pid291 $pid292 $pid293 $pid294 $pid295 $pid296 $pid297 $pid298 $pid299 $pid300 $pid301 $pid302 $pid303 $pid304 $pid305 $pid306 $pid307 $pid308 $pid309 $pid310 $pid311 $pid312 $pid313 $pid314 $pid315 $pid316 $pid317 $pid318 $pid319 $pid320 $pid321 $pid322 $pid323 $pid324 $pid325 $pid326 $pid327 $pid328 $pid329 $pid330 $pid331 $pid332 $pid333 $pid334 $pid335 $pid336 $pid337 $pid338 $pid339 $pid340 $pid341 $pid342 $pid343 $pid344 $pid345 $pid346 $pid347 $pid348 $pid349 $pid350 $pid351 $pid352 $pid353 $pid354 $pid355 $pid356 $pid357 $pid358 $pid359 $pid360 $pid361 $pid362 $pid363 $pid364 $pid365 $pid366 $pid367 $pid368 $pid369 $pid370 $pid371 $pid372 $pid373 $pid374 $pid375 $pid376 $pid377 $pid378 $pid379 $pid380 $pid381 $pid382 $pid383 $pid384 $pid385 $pid386 $pid387 $pid388 $pid389 $pid390 $pid391 $pid392 $pid393 $pid394 $pid395 $pid396 $pid397 $pid398 $pid399 $pid400 $pid401 $pid402 $pid403 $pid404 $pid405 $pid406 $pid407 $pid408 $pid409 $pid410 $pid411 $pid412 $pid413 $pid414 $pid415 $pid416 $pid417 $pid418 $pid419 $pid420 $pid421 $pid422 $pid423 $pid424 $pid425 $pid426 $pid427 $pid428 $pid429 $pid430 $pid431 $pid432 $pid433 $pid434 $pid435 $pid436 $pid437 $pid438 $pid439 $pid440 $pid441 $pid442 $pid443 $pid444 $pid445 $pid446 $pid447 $pid448 $pid449 $pid450 $pid451 $pid452 $pid453 $pid454 $pid455 $pid456 $pid457 $pid458 $pid459 $pid460 $pid461 $pid462 $pid463 $pid464 $pid465 $pid466 $pid467 $pid468 $pid469 $pid470 $pid471 $pid472 $pid473 $pid474 $pid475 $pid476 $pid477 $pid478 $pid479 $pid480 $pid481 $pid482 $pid483 $pid484 $pid485 $pid486 $pid487 $pid488 $pid489 $pid490 $pid491 $pid492 $pid493 $pid494 $pid495 $pid496 $pid497 $pid498 $pid499 $pid500 $pid501 $pid502 $pid503 $pid504 $pid505 $pid506 $pid507 $pid508 $pid509 $pid510 $pid511 $pid512 $pid513 $pid514 $pid515 $pid516 $pid517 $pid518 $pid519 $pid520 $pid521 $pid522 $pid523 $pid524 $pid525 $pid526 $pid527 $pid528 $pid529 $pid530 $pid531 $pid532 $pid533 $pid534 $pid535 $pid536 $pid537 $pid538 $pid539 $pid540 $pid541 $pid542 $pid543 $pid544 $pid545 $pid546 $pid547 $pid548 $pid549 $pid550 $pid551 $pid552 $pid553 $pid554 $pid555 $pid556 $pid557 $pid558 $pid559 $pid560 $pid561 $pid562 $pid563 $pid564 $pid565 $pid566 $pid567 $pid568 $pid569 $pid570 $pid571 $pid572 $pid573 $pid574 $pid575 $pid576 $pid577 $pid578 $pid579 $pid580 $pid581 $pid582 $pid583 $pid584 $pid585 $pid586 $pid587 $pid588 $pid589 $pid590 $pid591 $pid592 $pid593 $pid594 $pid595 $pid596 $pid597 $pid598 $pid599 $pid600 $pid601 $pid602 $pid603 $pid604 $pid605 $pid606 $pid607 $pid608 $pid609 $pid610 $pid611 $pid612 $pid613 $pid614 $pid615 $pid616 $pid617 $pid618 $pid619 $pid620 $pid621 $pid622 $pid623 $pid624 $pid625 $pid626 $pid627 $pid628 $pid629 $pid630 $pid631 $pid632 $pid633 $pid634 $pid635 $pid636 $pid637 $pid638 $pid639 $pid640 $pid641 $pid642 $pid643 $pid644 $pid645 $pid646 $pid647 $pid648 $pid649 $pid650 $pid651 $pid652 $pid653 $pid654 $pid655 $pid656 $pid657 $pid658 $pid659 $pid660 $pid661 $pid662 $pid663 $pid664 $pid665 $pid666 $pid667 $pid668 $pid669 $pid670 $pid671 $pid672 $pid673 $pid674 $pid675 $pid676 $pid677 $pid678 $pid679 $pid680 $pid681 $pid682 $pid683 $pid684 $pid685 $pid686 $pid687 $pid688 $pid689 $pid690 $pid691 $pid692 $pid693 $pid694 $pid695 $pid696 $pid697 $pid698 $pid699 $pid700 $pid701 $pid702 $pid703 $pid704 $pid705 $pid706 $pid707 $pid708 $pid709 $pid710 $pid711 $pid712 $pid713 $pid714 $pid715 $pid716 $pid717 $pid718 $pid719 $pid720 $pid721 $pid722 $pid723 $pid724 $pid725 $pid726 $pid727 $pid728 $pid729 $pid730 $pid731 $pid732 $pid733 $pid734 $pid735 $pid736 $pid737 $pid738 $pid739 $pid740 $pid741 $pid742 $pid743 $pid744 $pid745 $pid746 $pid747 $pid748 $pid749 $pid750 $pid751 $pid752 $pid753 $pid754 $pid755 $pid756 $pid757 $pid758 $pid759 $pid760 $pid761 $pid762 $pid763 $pid764 $pid765 $pid766 $pid767 $pid768 $pid769 $pid770 $pid771 $pid772 $pid773 $pid774 $pid775 $pid776 $pid777 $pid778 $pid779 $pid780 $pid781 $pid782 $pid783 $pid784 $pid785 $pid786 $pid787 $pid788 $pid789 $pid790 $pid791 $pid792 $pid793 $pid794 $pid795 $pid796 $pid797 $pid798 $pid799 $pid800


# --- Do insured loss kats ---

kat -s work/kat/il_S1_eltcalc_P1 work/kat/il_S1_eltcalc_P2 work/kat/il_S1_eltcalc_P3 work/kat/il_S1_eltcalc_P4 work/kat/il_S1_eltcalc_P5 work/kat/il_S1_eltcalc_P6 work/kat/il_S1_eltcalc_P7 work/kat/il_S1_eltcalc_P8 work/kat/il_S1_eltcalc_P9 work/kat/il_S1_eltcalc_P10 work/kat/il_S1_eltcalc_P11 work/kat/il_S1_eltcalc_P12 work/kat/il_S1_eltcalc_P13 work/kat/il_S1_eltcalc_P14 work/kat/il_S1_eltcalc_P15 work/kat/il_S1_eltcalc_P16 work/kat/il_S1_eltcalc_P17 work/kat/il_S1_eltcalc_P18 work/kat/il_S1_eltcalc_P19 work/kat/il_S1_eltcalc_P20 work/kat/il_S1_eltcalc_P21 work/kat/il_S1_eltcalc_P22 work/kat/il_S1_eltcalc_P23 work/kat/il_S1_eltcalc_P24 work/kat/il_S1_eltcalc_P25 work/kat/il_S1_eltcalc_P26 work/kat/il_S1_eltcalc_P27 work/kat/il_S1_eltcalc_P28 work/kat/il_S1_eltcalc_P29 work/kat/il_S1_eltcalc_P30 work/kat/il_S1_eltcalc_P31 work/kat/il_S1_eltcalc_P32 work/kat/il_S1_eltcalc_P33 work/kat/il_S1_eltcalc_P34 work/kat/il_S1_eltcalc_P35 work/kat/il_S1_eltcalc_P36 work/kat/il_S1_eltcalc_P37 work/kat/il_S1_eltcalc_P38 work/kat/il_S1_eltcalc_P39 work/kat/il_S1_eltcalc_P40 > output/il_S1_eltcalc.csv & kpid1=$!
kat work/kat/il_S1_pltcalc_P1 work/kat/il_S1_pltcalc_P2 work/kat/il_S1_pltcalc_P3 work/kat/il_S1_pltcalc_P4 work/kat/il_S1_pltcalc_P5 work/kat/il_S1_pltcalc_P6 work/kat/il_S1_pltcalc_P7 work/kat/il_S1_pltcalc_P8 work/kat/il_S1_pltcalc_P9 work/kat/il_S1_pltcalc_P10 work/kat/il_S1_pltcalc_P11 work/kat/il_S1_pltcalc_P12 work/kat/il_S1_pltcalc_P13 work/kat/il_S1_pltcalc_P14 work/kat/il_S1_pltcalc_P15 work/kat/il_S1_pltcalc_P16 work/kat/il_S1_pltcalc_P17 work/kat/il_S1_pltcalc_P18 work/kat/il_S1_pltcalc_P19 work/kat/il_S1_pltcalc_P20 work/kat/il_S1_pltcalc_P21 work/kat/il_S1_pltcalc_P22 work/kat/il_S1_pltcalc_P23 work/kat/il_S1_pltcalc_P24 work/kat/il_S1_pltcalc_P25 work/kat/il_S1_pltcalc_P26 work/kat/il_S1_pltcalc_P27 work/kat/il_S1_pltcalc_P28 work/kat/il_S1_pltcalc_P29 work/kat/il_S1_pltcalc_P30 work/kat/il_S1_pltcalc_P31 work/kat/il_S1_pltcalc_P32 work/kat/il_S1_pltcalc_P33 work/kat/il_S1_pltcalc_P34 work/kat/il_S1_pltcalc_P35 work/kat/il_S1_pltcalc_P36 work/kat/il_S1_pltcalc_P37 work/kat/il_S1_pltcalc_P38 work/kat/il_S1_pltcalc_P39 work/kat/il_S1_pltcalc_P40 > output/il_S1_pltcalc.csv & kpid2=$!
kat work/kat/il_S1_summarycalc_P1 work/kat/il_S1_summarycalc_P2 work/kat/il_S1_summarycalc_P3 work/kat/il_S1_summarycalc_P4 work/kat/il_S1_summarycalc_P5 work/kat/il_S1_summarycalc_P6 work/kat/il_S1_summarycalc_P7 work/kat/il_S1_summarycalc_P8 work/kat/il_S1_summarycalc_P9 work/kat/il_S1_summarycalc_P10 work/kat/il_S1_summarycalc_P11 work/kat/il_S1_summarycalc_P12 work/kat/il_S1_summarycalc_P13 work/kat/il_S1_summarycalc_P14 work/kat/il_S1_summarycalc_P15 work/kat/il_S1_summarycalc_P16 work/kat/il_S1_summarycalc_P17 work/kat/il_S1_summarycalc_P18 work/kat/il_S1_summarycalc_P19 work/kat/il_S1_summarycalc_P20 work/kat/il_S1_summarycalc_P21 work/kat/il_S1_summarycalc_P22 work/kat/il_S1_summarycalc_P23 work/kat/il_S1_summarycalc_P24 work/kat/il_S1_summarycalc_P25 work/kat/il_S1_summarycalc_P26 work/kat/il_S1_summarycalc_P27 work/kat/il_S1_summarycalc_P28 work/kat/il_S1_summarycalc_P29 work/kat/il_S1_summarycalc_P30 work/kat/il_S1_summarycalc_P31 work/kat/il_S1_summarycalc_P32 work/kat/il_S1_summarycalc_P33 work/kat/il_S1_summarycalc_P34 work/kat/il_S1_summarycalc_P35 work/kat/il_S1_summarycalc_P36 work/kat/il_S1_summarycalc_P37 work/kat/il_S1_summarycalc_P38 work/kat/il_S1_summarycalc_P39 work/kat/il_S1_summarycalc_P40 > output/il_S1_summarycalc.csv & kpid3=$!

# --- Do insured loss kats for fully correlated output ---

kat -s work/full_correlation/kat/il_S1_eltcalc_P1 work/full_correlation/kat/il_S1_eltcalc_P2 work/full_correlation/kat/il_S1_eltcalc_P3 work/full_correlation/kat/il_S1_eltcalc_P4 work/full_correlation/kat/il_S1_eltcalc_P5 work/full_correlation/kat/il_S1_eltcalc_P6 work/full_correlation/kat/il_S1_eltcalc_P7 work/full_correlation/kat/il_S1_eltcalc_P8 work/full_correlation/kat/il_S1_eltcalc_P9 work/full_correlation/kat/il_S1_eltcalc_P10 work/full_correlation/kat/il_S1_eltcalc_P11 work/full_correlation/kat/il_S1_eltcalc_P12 work/full_correlation/kat/il_S1_eltcalc_P13 work/full_correlation/kat/il_S1_eltcalc_P14 work/full_correlation/kat/il_S1_eltcalc_P15 work/full_correlation/kat/il_S1_eltcalc_P16 work/full_correlation/kat/il_S1_eltcalc_P17 work/full_correlation/kat/il_S1_eltcalc_P18 work/full_correlation/kat/il_S1_eltcalc_P19 work/full_correlation/kat/il_S1_eltcalc_P20 work/full_correlation/kat/il_S1_eltcalc_P21 work/full_correlation/kat/il_S1_eltcalc_P22 work/full_correlation/kat/il_S1_eltcalc_P23 work/full_correlation/kat/il_S1_eltcalc_P24 work/full_correlation/kat/il_S1_eltcalc_P25 work/full_correlation/kat/il_S1_eltcalc_P26 work/full_correlation/kat/il_S1_eltcalc_P27 work/full_correlation/kat/il_S1_eltcalc_P28 work/full_correlation/kat/il_S1_eltcalc_P29 work/full_correlation/kat/il_S1_eltcalc_P30 work/full_correlation/kat/il_S1_eltcalc_P31 work/full_correlation/kat/il_S1_eltcalc_P32 work/full_correlation/kat/il_S1_eltcalc_P33 work/full_correlation/kat/il_S1_eltcalc_P34 work/full_correlation/kat/il_S1_eltcalc_P35 work/full_correlation/kat/il_S1_eltcalc_P36 work/full_correlation/kat/il_S1_eltcalc_P37 work/full_correlation/kat/il_S1_eltcalc_P38 work/full_correlation/kat/il_S1_eltcalc_P39 work/full_correlation/kat/il_S1_eltcalc_P40 > output/full_correlation/il_S1_eltcalc.csv & kpid4=$!
kat work/full_correlation/kat/il_S1_pltcalc_P1 work/full_correlation/kat/il_S1_pltcalc_P2 work/full_correlation/kat/il_S1_pltcalc_P3 work/full_correlation/kat/il_S1_pltcalc_P4 work/full_correlation/kat/il_S1_pltcalc_P5 work/full_correlation/kat/il_S1_pltcalc_P6 work/full_correlation/kat/il_S1_pltcalc_P7 work/full_correlation/kat/il_S1_pltcalc_P8 work/full_correlation/kat/il_S1_pltcalc_P9 work/full_correlation/kat/il_S1_pltcalc_P10 work/full_correlation/kat/il_S1_pltcalc_P11 work/full_correlation/kat/il_S1_pltcalc_P12 work/full_correlation/kat/il_S1_pltcalc_P13 work/full_correlation/kat/il_S1_pltcalc_P14 work/full_correlation/kat/il_S1_pltcalc_P15 work/full_correlation/kat/il_S1_pltcalc_P16 work/full_correlation/kat/il_S1_pltcalc_P17 work/full_correlation/kat/il_S1_pltcalc_P18 work/full_correlation/kat/il_S1_pltcalc_P19 work/full_correlation/kat/il_S1_pltcalc_P20 work/full_correlation/kat/il_S1_pltcalc_P21 work/full_correlation/kat/il_S1_pltcalc_P22 work/full_correlation/kat/il_S1_pltcalc_P23 work/full_correlation/kat/il_S1_pltcalc_P24 work/full_correlation/kat/il_S1_pltcalc_P25 work/full_correlation/kat/il_S1_pltcalc_P26 work/full_correlation/kat/il_S1_pltcalc_P27 work/full_correlation/kat/il_S1_pltcalc_P28 work/full_correlation/kat/il_S1_pltcalc_P29 work/full_correlation/kat/il_S1_pltcalc_P30 work/full_correlation/kat/il_S1_pltcalc_P31 work/full_correlation/kat/il_S1_pltcalc_P32 work/full_correlation/kat/il_S1_pltcalc_P33 work/full_correlation/kat/il_S1_pltcalc_P34 work/full_correlation/kat/il_S1_pltcalc_P35 work/full_correlation/kat/il_S1_pltcalc_P36 work/full_correlation/kat/il_S1_pltcalc_P37 work/full_correlation/kat/il_S1_pltcalc_P38 work/full_correlation/kat/il_S1_pltcalc_P39 work/full_correlation/kat/il_S1_pltcalc_P40 > output/full_correlation/il_S1_pltcalc.csv & kpid5=$!
kat work/full_correlation/kat/il_S1_summarycalc_P1 work/full_correlation/kat/il_S1_summarycalc_P2 work/full_correlation/kat/il_S1_summarycalc_P3 work/full_correlation/kat/il_S1_summarycalc_P4 work/full_correlation/kat/il_S1_summarycalc_P5 work/full_correlation/kat/il_S1_summarycalc_P6 work/full_correlation/kat/il_S1_summarycalc_P7 work/full_correlation/kat/il_S1_summarycalc_P8 work/full_correlation/kat/il_S1_summarycalc_P9 work/full_correlation/kat/il_S1_summarycalc_P10 work/full_correlation/kat/il_S1_summarycalc_P11 work/full_correlation/kat/il_S1_summarycalc_P12 work/full_correlation/kat/il_S1_summarycalc_P13 work/full_correlation/kat/il_S1_summarycalc_P14 work/full_correlation/kat/il_S1_summarycalc_P15 work/full_correlation/kat/il_S1_summarycalc_P16 work/full_correlation/kat/il_S1_summarycalc_P17 work/full_correlation/kat/il_S1_summarycalc_P18 work/full_correlation/kat/il_S1_summarycalc_P19 work/full_correlation/kat/il_S1_summarycalc_P20 work/full_correlation/kat/il_S1_summarycalc_P21 work/full_correlation/kat/il_S1_summarycalc_P22 work/full_correlation/kat/il_S1_summarycalc_P23 work/full_correlation/kat/il_S1_summarycalc_P24 work/full_correlation/kat/il_S1_summarycalc_P25 work/full_correlation/kat/il_S1_summarycalc_P26 work/full_correlation/kat/il_S1_summarycalc_P27 work/full_correlation/kat/il_S1_summarycalc_P28 work/full_correlation/kat/il_S1_summarycalc_P29 work/full_correlation/kat/il_S1_summarycalc_P30 work/full_correlation/kat/il_S1_summarycalc_P31 work/full_correlation/kat/il_S1_summarycalc_P32 work/full_correlation/kat/il_S1_summarycalc_P33 work/full_correlation/kat/il_S1_summarycalc_P34 work/full_correlation/kat/il_S1_summarycalc_P35 work/full_correlation/kat/il_S1_summarycalc_P36 work/full_correlation/kat/il_S1_summarycalc_P37 work/full_correlation/kat/il_S1_summarycalc_P38 work/full_correlation/kat/il_S1_summarycalc_P39 work/full_correlation/kat/il_S1_summarycalc_P40 > output/full_correlation/il_S1_summarycalc.csv & kpid6=$!

# --- Do ground up loss kats ---

kat -s work/kat/gul_S1_eltcalc_P1 work/kat/gul_S1_eltcalc_P2 work/kat/gul_S1_eltcalc_P3 work/kat/gul_S1_eltcalc_P4 work/kat/gul_S1_eltcalc_P5 work/kat/gul_S1_eltcalc_P6 work/kat/gul_S1_eltcalc_P7 work/kat/gul_S1_eltcalc_P8 work/kat/gul_S1_eltcalc_P9 work/kat/gul_S1_eltcalc_P10 work/kat/gul_S1_eltcalc_P11 work/kat/gul_S1_eltcalc_P12 work/kat/gul_S1_eltcalc_P13 work/kat/gul_S1_eltcalc_P14 work/kat/gul_S1_eltcalc_P15 work/kat/gul_S1_eltcalc_P16 work/kat/gul_S1_eltcalc_P17 work/kat/gul_S1_eltcalc_P18 work/kat/gul_S1_eltcalc_P19 work/kat/gul_S1_eltcalc_P20 work/kat/gul_S1_eltcalc_P21 work/kat/gul_S1_eltcalc_P22 work/kat/gul_S1_eltcalc_P23 work/kat/gul_S1_eltcalc_P24 work/kat/gul_S1_eltcalc_P25 work/kat/gul_S1_eltcalc_P26 work/kat/gul_S1_eltcalc_P27 work/kat/gul_S1_eltcalc_P28 work/kat/gul_S1_eltcalc_P29 work/kat/gul_S1_eltcalc_P30 work/kat/gul_S1_eltcalc_P31 work/kat/gul_S1_eltcalc_P32 work/kat/gul_S1_eltcalc_P33 work/kat/gul_S1_eltcalc_P34 work/kat/gul_S1_eltcalc_P35 work/kat/gul_S1_eltcalc_P36 work/kat/gul_S1_eltcalc_P37 work/kat/gul_S1_eltcalc_P38 work/kat/gul_S1_eltcalc_P39 work/kat/gul_S1_eltcalc_P40 > output/gul_S1_eltcalc.csv & kpid7=$!
kat work/kat/gul_S1_pltcalc_P1 work/kat/gul_S1_pltcalc_P2 work/kat/gul_S1_pltcalc_P3 work/kat/gul_S1_pltcalc_P4 work/kat/gul_S1_pltcalc_P5 work/kat/gul_S1_pltcalc_P6 work/kat/gul_S1_pltcalc_P7 work/kat/gul_S1_pltcalc_P8 work/kat/gul_S1_pltcalc_P9 work/kat/gul_S1_pltcalc_P10 work/kat/gul_S1_pltcalc_P11 work/kat/gul_S1_pltcalc_P12 work/kat/gul_S1_pltcalc_P13 work/kat/gul_S1_pltcalc_P14 work/kat/gul_S1_pltcalc_P15 work/kat/gul_S1_pltcalc_P16 work/kat/gul_S1_pltcalc_P17 work/kat/gul_S1_pltcalc_P18 work/kat/gul_S1_pltcalc_P19 work/kat/gul_S1_pltcalc_P20 work/kat/gul_S1_pltcalc_P21 work/kat/gul_S1_pltcalc_P22 work/kat/gul_S1_pltcalc_P23 work/kat/gul_S1_pltcalc_P24 work/kat/gul_S1_pltcalc_P25 work/kat/gul_S1_pltcalc_P26 work/kat/gul_S1_pltcalc_P27 work/kat/gul_S1_pltcalc_P28 work/kat/gul_S1_pltcalc_P29 work/kat/gul_S1_pltcalc_P30 work/kat/gul_S1_pltcalc_P31 work/kat/gul_S1_pltcalc_P32 work/kat/gul_S1_pltcalc_P33 work/kat/gul_S1_pltcalc_P34 work/kat/gul_S1_pltcalc_P35 work/kat/gul_S1_pltcalc_P36 work/kat/gul_S1_pltcalc_P37 work/kat/gul_S1_pltcalc_P38 work/kat/gul_S1_pltcalc_P39 work/kat/gul_S1_pltcalc_P40 > output/gul_S1_pltcalc.csv & kpid8=$!
kat work/kat/gul_S1_summarycalc_P1 work/kat/gul_S1_summarycalc_P2 work/kat/gul_S1_summarycalc_P3 work/kat/gul_S1_summarycalc_P4 work/kat/gul_S1_summarycalc_P5 work/kat/gul_S1_summarycalc_P6 work/kat/gul_S1_summarycalc_P7 work/kat/gul_S1_summarycalc_P8 work/kat/gul_S1_summarycalc_P9 work/kat/gul_S1_summarycalc_P10 work/kat/gul_S1_summarycalc_P11 work/kat/gul_S1_summarycalc_P12 work/kat/gul_S1_summarycalc_P13 work/kat/gul_S1_summarycalc_P14 work/kat/gul_S1_summarycalc_P15 work/kat/gul_S1_summarycalc_P16 work/kat/gul_S1_summarycalc_P17 work/kat/gul_S1_summarycalc_P18 work/kat/gul_S1_summarycalc_P19 work/kat/gul_S1_summarycalc_P20 work/kat/gul_S1_summarycalc_P21 work/kat/gul_S1_summarycalc_P22 work/kat/gul_S1_summarycalc_P23 work/kat/gul_S1_summarycalc_P24 work/kat/gul_S1_summarycalc_P25 work/kat/gul_S1_summarycalc_P26 work/kat/gul_S1_summarycalc_P27 work/kat/gul_S1_summarycalc_P28 work/kat/gul_S1_summarycalc_P29 work/kat/gul_S1_summarycalc_P30 work/kat/gul_S1_summarycalc_P31 work/kat/gul_S1_summarycalc_P32 work/kat/gul_S1_summarycalc_P33 work/kat/gul_S1_summarycalc_P34 work/kat/gul_S1_summarycalc_P35 work/kat/gul_S1_summarycalc_P36 work/kat/gul_S1_summarycalc_P37 work/kat/gul_S1_summarycalc_P38 work/kat/gul_S1_summarycalc_P39 work/kat/gul_S1_summarycalc_P40 > output/gul_S1_summarycalc.csv & kpid9=$!

# --- Do ground up loss kats for fully correlated output ---

kat -s work/full_correlation/kat/gul_S1_eltcalc_P1 work/full_correlation/kat/gul_S1_eltcalc_P2 work/full_correlation/kat/gul_S1_eltcalc_P3 work/full_correlation/kat/gul_S1_eltcalc_P4 work/full_correlation/kat/gul_S1_eltcalc_P5 work/full_correlation/kat/gul_S1_eltcalc_P6 work/full_correlation/kat/gul_S1_eltcalc_P7 work/full_correlation/kat/gul_S1_eltcalc_P8 work/full_correlation/kat/gul_S1_eltcalc_P9 work/full_correlation/kat/gul_S1_eltcalc_P10 work/full_correlation/kat/gul_S1_eltcalc_P11 work/full_correlation/kat/gul_S1_eltcalc_P12 work/full_correlation/kat/gul_S1_eltcalc_P13 work/full_correlation/kat/gul_S1_eltcalc_P14 work/full_correlation/kat/gul_S1_eltcalc_P15 work/full_correlation/kat/gul_S1_eltcalc_P16 work/full_correlation/kat/gul_S1_eltcalc_P17 work/full_correlation/kat/gul_S1_eltcalc_P18 work/full_correlation/kat/gul_S1_eltcalc_P19 work/full_correlation/kat/gul_S1_eltcalc_P20 work/full_correlation/kat/gul_S1_eltcalc_P21 work/full_correlation/kat/gul_S1_eltcalc_P22 work/full_correlation/kat/gul_S1_eltcalc_P23 work/full_correlation/kat/gul_S1_eltcalc_P24 work/full_correlation/kat/gul_S1_eltcalc_P25 work/full_correlation/kat/gul_S1_eltcalc_P26 work/full_correlation/kat/gul_S1_eltcalc_P27 work/full_correlation/kat/gul_S1_eltcalc_P28 work/full_correlation/kat/gul_S1_eltcalc_P29 work/full_correlation/kat/gul_S1_eltcalc_P30 work/full_correlation/kat/gul_S1_eltcalc_P31 work/full_correlation/kat/gul_S1_eltcalc_P32 work/full_correlation/kat/gul_S1_eltcalc_P33 work/full_correlation/kat/gul_S1_eltcalc_P34 work/full_correlation/kat/gul_S1_eltcalc_P35 work/full_correlation/kat/gul_S1_eltcalc_P36 work/full_correlation/kat/gul_S1_eltcalc_P37 work/full_correlation/kat/gul_S1_eltcalc_P38 work/full_correlation/kat/gul_S1_eltcalc_P39 work/full_correlation/kat/gul_S1_eltcalc_P40 > output/full_correlation/gul_S1_eltcalc.csv & kpid10=$!
kat work/full_correlation/kat/gul_S1_pltcalc_P1 work/full_correlation/kat/gul_S1_pltcalc_P2 work/full_correlation/kat/gul_S1_pltcalc_P3 work/full_correlation/kat/gul_S1_pltcalc_P4 work/full_correlation/kat/gul_S1_pltcalc_P5 work/full_correlation/kat/gul_S1_pltcalc_P6 work/full_correlation/kat/gul_S1_pltcalc_P7 work/full_correlation/kat/gul_S1_pltcalc_P8 work/full_correlation/kat/gul_S1_pltcalc_P9 work/full_correlation/kat/gul_S1_pltcalc_P10 work/full_correlation/kat/gul_S1_pltcalc_P11 work/full_correlation/kat/gul_S1_pltcalc_P12 work/full_correlation/kat/gul_S1_pltcalc_P13 work/full_correlation/kat/gul_S1_pltcalc_P14 work/full_correlation/kat/gul_S1_pltcalc_P15 work/full_correlation/kat/gul_S1_pltcalc_P16 work/full_correlation/kat/gul_S1_pltcalc_P17 work/full_correlation/kat/gul_S1_pltcalc_P18 work/full_correlation/kat/gul_S1_pltcalc_P19 work/full_correlation/kat/gul_S1_pltcalc_P20 work/full_correlation/kat/gul_S1_pltcalc_P21 work/full_correlation/kat/gul_S1_pltcalc_P22 work/full_correlation/kat/gul_S1_pltcalc_P23 work/full_correlation/kat/gul_S1_pltcalc_P24 work/full_correlation/kat/gul_S1_pltcalc_P25 work/full_correlation/kat/gul_S1_pltcalc_P26 work/full_correlation/kat/gul_S1_pltcalc_P27 work/full_correlation/kat/gul_S1_pltcalc_P28 work/full_correlation/kat/gul_S1_pltcalc_P29 work/full_correlation/kat/gul_S1_pltcalc_P30 work/full_correlation/kat/gul_S1_pltcalc_P31 work/full_correlation/kat/gul_S1_pltcalc_P32 work/full_correlation/kat/gul_S1_pltcalc_P33 work/full_correlation/kat/gul_S1_pltcalc_P34 work/full_correlation/kat/gul_S1_pltcalc_P35 work/full_correlation/kat/gul_S1_pltcalc_P36 work/full_correlation/kat/gul_S1_pltcalc_P37 work/full_correlation/kat/gul_S1_pltcalc_P38 work/full_correlation/kat/gul_S1_pltcalc_P39 work/full_correlation/kat/gul_S1_pltcalc_P40 > output/full_correlation/gul_S1_pltcalc.csv & kpid11=$!
kat work/full_correlation/kat/gul_S1_summarycalc_P1 work/full_correlation/kat/gul_S1_summarycalc_P2 work/full_correlation/kat/gul_S1_summarycalc_P3 work/full_correlation/kat/gul_S1_summarycalc_P4 work/full_correlation/kat/gul_S1_summarycalc_P5 work/full_correlation/kat/gul_S1_summarycalc_P6 work/full_correlation/kat/gul_S1_summarycalc_P7 work/full_correlation/kat/gul_S1_summarycalc_P8 work/full_correlation/kat/gul_S1_summarycalc_P9 work/full_correlation/kat/gul_S1_summarycalc_P10 work/full_correlation/kat/gul_S1_summarycalc_P11 work/full_correlation/kat/gul_S1_summarycalc_P12 work/full_correlation/kat/gul_S1_summarycalc_P13 work/full_correlation/kat/gul_S1_summarycalc_P14 work/full_correlation/kat/gul_S1_summarycalc_P15 work/full_correlation/kat/gul_S1_summarycalc_P16 work/full_correlation/kat/gul_S1_summarycalc_P17 work/full_correlation/kat/gul_S1_summarycalc_P18 work/full_correlation/kat/gul_S1_summarycalc_P19 work/full_correlation/kat/gul_S1_summarycalc_P20 work/full_correlation/kat/gul_S1_summarycalc_P21 work/full_correlation/kat/gul_S1_summarycalc_P22 work/full_correlation/kat/gul_S1_summarycalc_P23 work/full_correlation/kat/gul_S1_summarycalc_P24 work/full_correlation/kat/gul_S1_summarycalc_P25 work/full_correlation/kat/gul_S1_summarycalc_P26 work/full_correlation/kat/gul_S1_summarycalc_P27 work/full_correlation/kat/gul_S1_summarycalc_P28 work/full_correlation/kat/gul_S1_summarycalc_P29 work/full_correlation/kat/gul_S1_summarycalc_P30 work/full_correlation/kat/gul_S1_summarycalc_P31 work/full_correlation/kat/gul_S1_summarycalc_P32 work/full_correlation/kat/gul_S1_summarycalc_P33 work/full_correlation/kat/gul_S1_summarycalc_P34 work/full_correlation/kat/gul_S1_summarycalc_P35 work/full_correlation/kat/gul_S1_summarycalc_P36 work/full_correlation/kat/gul_S1_summarycalc_P37 work/full_correlation/kat/gul_S1_summarycalc_P38 work/full_correlation/kat/gul_S1_summarycalc_P39 work/full_correlation/kat/gul_S1_summarycalc_P40 > output/full_correlation/gul_S1_summarycalc.csv & kpid12=$!
wait $kpid1 $kpid2 $kpid3 $kpid4 $kpid5 $kpid6 $kpid7 $kpid8 $kpid9 $kpid10 $kpid11 $kpid12


aalcalc -Kil_S1_summaryaalcalc > output/il_S1_aalcalc.csv & lpid1=$!
leccalc -r -Kil_S1_summaryleccalc -F output/il_S1_leccalc_full_uncertainty_aep.csv -f output/il_S1_leccalc_full_uncertainty_oep.csv -S output/il_S1_leccalc_sample_mean_aep.csv -s output/il_S1_leccalc_sample_mean_oep.csv -W output/il_S1_leccalc_wheatsheaf_aep.csv -M output/il_S1_leccalc_wheatsheaf_mean_aep.csv -m output/il_S1_leccalc_wheatsheaf_mean_oep.csv -w output/il_S1_leccalc_wheatsheaf_oep.csv & lpid2=$!
aalcalc -Kgul_S1_summaryaalcalc > output/gul_S1_aalcalc.csv & lpid3=$!
leccalc -r -Kgul_S1_summaryleccalc -F output/gul_S1_leccalc_full_uncertainty_aep.csv -f output/gul_S1_leccalc_full_uncertainty_oep.csv -S output/gul_S1_leccalc_sample_mean_aep.csv -s output/gul_S1_leccalc_sample_mean_oep.csv -W output/gul_S1_leccalc_wheatsheaf_aep.csv -M output/gul_S1_leccalc_wheatsheaf_mean_aep.csv -m output/gul_S1_leccalc_wheatsheaf_mean_oep.csv -w output/gul_S1_leccalc_wheatsheaf_oep.csv & lpid4=$!
aalcalc -Kfull_correlation/il_S1_summaryaalcalc > output/full_correlation/il_S1_aalcalc.csv & lpid5=$!
leccalc -r -Kfull_correlation/il_S1_summaryleccalc -F output/full_correlation/il_S1_leccalc_full_uncertainty_aep.csv -f output/full_correlation/il_S1_leccalc_full_uncertainty_oep.csv -S output/full_correlation/il_S1_leccalc_sample_mean_aep.csv -s output/full_correlation/il_S1_leccalc_sample_mean_oep.csv -W output/full_correlation/il_S1_leccalc_wheatsheaf_aep.csv -M output/full_correlation/il_S1_leccalc_wheatsheaf_mean_aep.csv -m output/full_correlation/il_S1_leccalc_wheatsheaf_mean_oep.csv -w output/full_correlation/il_S1_leccalc_wheatsheaf_oep.csv & lpid6=$!
aalcalc -Kfull_correlation/gul_S1_summaryaalcalc > output/full_correlation/gul_S1_aalcalc.csv & lpid7=$!
leccalc -r -Kfull_correlation/gul_S1_summaryleccalc -F output/full_correlation/gul_S1_leccalc_full_uncertainty_aep.csv -f output/full_correlation/gul_S1_leccalc_full_uncertainty_oep.csv -S output/full_correlation/gul_S1_leccalc_sample_mean_aep.csv -s output/full_correlation/gul_S1_leccalc_sample_mean_oep.csv -W output/full_correlation/gul_S1_leccalc_wheatsheaf_aep.csv -M output/full_correlation/gul_S1_leccalc_wheatsheaf_mean_aep.csv -m output/full_correlation/gul_S1_leccalc_wheatsheaf_mean_oep.csv -w output/full_correlation/gul_S1_leccalc_wheatsheaf_oep.csv & lpid8=$!
wait $lpid1 $lpid2 $lpid3 $lpid4 $lpid5 $lpid6 $lpid7 $lpid8

rm -R -f work/*
rm -R -f fifo/*
