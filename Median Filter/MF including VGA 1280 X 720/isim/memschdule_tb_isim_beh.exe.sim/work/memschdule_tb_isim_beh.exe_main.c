/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;

char *IEEE_P_2592010699;
char *STD_STANDARD;
char *STD_TEXTIO;
char *IEEE_P_3499444699;
char *IEEE_P_3620187407;
char *IEEE_P_3564397177;


int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    ieee_p_2592010699_init();
    ieee_p_3499444699_init();
    ieee_p_3620187407_init();
    std_textio_init();
    ieee_p_3564397177_init();
    xilinxcorelib_a_1370187620_2959432447_init();
    xilinxcorelib_a_3602558784_1709443946_init();
    xilinxcorelib_a_1691161846_0543512595_init();
    xilinxcorelib_a_0286164342_3212880686_init();
    work_a_0384390406_4121825009_init();
    xilinxcorelib_a_0381194655_2959432447_init();
    xilinxcorelib_a_0534374128_0543512595_init();
    xilinxcorelib_a_2250208615_3212880686_init();
    work_a_1631732537_0415684324_init();
    work_a_3177916969_3212880686_init();
    work_a_3632217263_3212880686_init();
    work_a_4025145175_3212880686_init();
    work_a_2952847472_3212880686_init();
    work_a_2784992895_2372691052_init();


    xsi_register_tops("work_a_2784992895_2372691052");

    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);
    STD_STANDARD = xsi_get_engine_memory("std_standard");
    STD_TEXTIO = xsi_get_engine_memory("std_textio");
    IEEE_P_3499444699 = xsi_get_engine_memory("ieee_p_3499444699");
    IEEE_P_3620187407 = xsi_get_engine_memory("ieee_p_3620187407");
    IEEE_P_3564397177 = xsi_get_engine_memory("ieee_p_3564397177");

    return xsi_run_simulation(argc, argv);

}
