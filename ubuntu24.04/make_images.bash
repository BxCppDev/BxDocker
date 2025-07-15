#!/usr/bin/env bash

opwd="$(pwd)"
cache_opt=
proxy_opt=
proxy_value=
doInspect=false

distrib="ubuntu24.04"

target="all"

function my_exit()
{
    local _errorCode=0
    cd ${opwd}
    exit ${erroCode}
}

if [ ! -f .${distrib} ]; then
    echo >&2 "[error] This script must run for the '${distrib}' directory"
    my_exit 1
fi

function parse_cl()
{
    proxy_value=

    while [ "$1" ]; do
	_token="$1"
	echo >&2 "[log] token='${_token}'"
	if [ "x${_token:0:1}" = "x-" ]; then
	    _opt="${_token}"
	    echo >&2 "[log] opt='${_opt}'"
	    if [ "x${_opt}" = "x-c" -o "x${_opt}" = "x--no-cache" ]; then
		echo >&2 "[log] run with no cache"
		cache_opt="--no-cache"
	    elif [ "x${_opt}" = "x-p" ]; then
		shift 1
		echo >&2 "[log] run with proxy"
		proxy_value="$1"
	    elif [ "x${_opt}" = "x--base" ]; then
		target="base"
	    elif [ "x${_opt}" = "x--bx3build" ]; then
		target="bx3build"
	    elif [ "x${_opt}" = "x--bayeux3" ]; then
		target="bayeux3"
	    elif [ "x${_opt}" = "x--inspect" ]; then		
		doInspect=true
	    else
		echo >&2 "[error] invalid option='${_opt}'"
		return 1
	    fi
	else
	    _arg="${_token}"
	    echo >&2 "[log] arg='${_arg}'"
	fi
	shift 1
    done
    echo >&2 "[log] cache_opt='${cache_opt}'"
    echo >&2 "[log] proxy_value='${proxy_value}'"
    return 0
}

parse_cl $@
if [ $? -ne 0 ]; then
    my_exit 1
fi
    
if [ "x${HTTPS_PROXY}" != "x" ]; then    
   proxy_value="${HTTPS_PROXY}"
fi
echo >&2 "[log] proxy_value='${proxy_value}'"

if [ "x${proxy_value}" != "x" ]; then
    proxy_opt="--build-arg \"http_proxy=${proxy_value}\" --build-arg \"https_proxy=${proxy_value}\""
fi
echo >&2 "[log] proxy_opt='${proxy_opt}'"
# my_exit 1

function make_docker_image_base()
{
    local _img_tag="bxcppdev-${distrib}-base:1"
    echo >&2 "[log] Building image '${_img_tag}'..."
    cd ./bxcppdev-base_1
    docker build ${cache_opt} ${proxy_opt} --progress=plain --tag="${_img_tag}" .
    if [ $? -ne 0 ]; then
	echo >&2 "[error] Docker build failed"
	cd ${opwd}
	return 1
    fi
    if [ ${doInspect} = true ]; then
	docker image inspect ${_img_tag}
    fi
    cd ${opwd}
    return 0
}
    

function make_docker_image_bx3build()
{
    local _img_tag="bxcppdev-${distrib}-bx3build:1"
    echo >&2 "[log] Building image '${_img_tag}'..."
    cd ./bxcppdev-bx3build_1
    docker build ${cache_opt} ${proxy_opt} --progress=plain --tag="${_img_tag}" .
    if [ $? -ne 0 ]; then
	echo >&2 "[error] Docker build failed"
	cd ${opwd}
	return 1
    fi
    if [ ${doInspect} = true ]; then
	docker image inspect ${_img_tag}
    fi
    cd ${opwd}
    return 0
}
   

function make_docker_image_bayeux3_5_5()
{
    local _img_tag="bxcppdev-${distrib}-bayeux:3.5.5"
    echo >&2 "[log] Building image '${_img_tag}'..."
    cd ./bxcppdev-bayeux_3.5.5
    docker build ${cache_opt} ${proxy_opt} --progress=plain --tag="${_img_tag}" .
    if [ $? -ne 0 ]; then
	echo >&2 "[error] Docker build failed"
	cd ${opwd}
	return 1
    fi
    if [ ${doInspect} = true ]; then
	docker image inspect ${_img_tag}
    fi
    cd ${opwd}
    return 0
}


if [ "${target}" = "all" -o "${target}" = "base" ]; then
    cd ${opwd}
    make_docker_image_base
    if [ $? -ne 0 ]; then
	my_exit 1
    fi
fi


if [ "${target}" = "all" -o "${target}" = "bx3build" ]; then
    cd ${opwd}
    make_docker_image_bx3build
    if [ $? -ne 0 ]; then
	my_exit 1
    fi
fi


if [ "${target}" = "all" -o "${target}" = "bayeux3" ]; then
    cd ${opwd}
    make_docker_image_bayeux3_5_5
    if [ $? -ne 0 ]; then
	my_exit 1
    fi
fi


my_exit 0
