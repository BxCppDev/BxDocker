source ${BX_CLHEP_SETUP_SCRIPT}
source ${BX_BXDECAY0_SETUP_SCRIPT}
source ${BX_G4DATASETS_SETUP_SCRIPT}
source ${BX_GEANT4_SETUP_SCRIPT}

function bayeux_build_setup()
{
    clhep_2_1_4_2_setup
    bxdecay0_1_1_2_setup
    g4datasets_9_6_4_setup
    geant4_9_6_4_setup
    source ${BX_ROOT_SETUP_SCRIPT}
 
    return 0
}

export -f bayeux_build_setup
