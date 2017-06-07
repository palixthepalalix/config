if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

function weather() {
    curl -s "http://api.wunderground.com/auto/wui/geo/ForecastXML/index.xml?query=10011"|perl -ne '/<title>([^<]+)/&&printf "%s: ",$1;/<fcttext>([^<]+)/&&print $1,"\n"';
}

function go() {
  # a function to use go on jump with a couple of improvements
  if [ $# -eq 0 ]; then
    # 0 arg supplied, check if clipboard has hostname and if it looks right, ssh to it
    h=`/usr/bin/pbpaste`
    if [ `echo $h | perl -ne 'if (/^\d{2,}\.[\w-]+\.[\w-]+\.\w{3,4}$/) {print 1;} else { print 0; }'` -eq 1 ]; then
      ssh $h -n "echo -ne ""\033]0;""$h""\007"""
      exit
    fi
  fi

  if [ $# -eq 1 ]; then
    if [ `echo $1 | perl -ne 'if (/^\d{2,}\.[\w-]+\.[\w-]+\.\w{3,4}$/) {print 1;} else { print 0; }'` -eq 1 ]; then
      # 1 arg supplied, probably well-formed hostname as it matched regexp, so try ssh directly
      ssh $1
      exit
    fi
  fi

  if [ $# -gt 1 ] && [[ $2 =~ ^(test)?[0-9]{4,}$ ]] && [ -n `cut -f2 -d' ' ~/app_aliases | grep "^$1$"` ] ; then
    local num="01"
    local app="$1"
    local env="test${2/test/}"
    if [ -n "$3" ]; then
      num="$3"
    fi
    app=`grep " $1$" ~/app_aliases | cut -f1 -d' '`

    local hostname="$num-$app-$env.envnxs.net"
    local cmd="ssh -Atq -oStrictHostKeyChecking=no $hostname"
    echo $cmd
    $cmd
  else
   jump go $@
  fi
}

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "
export PATH="/usr/local/sbin:$PATH"
