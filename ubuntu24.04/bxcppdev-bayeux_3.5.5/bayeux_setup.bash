source ${BX_BAYEUX_SETUP_SCRIPT}

function bayeux_setup()
{
    bayeux_build_setup
    return 0
}

export -f bayeux_setup
