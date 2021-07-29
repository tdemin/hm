params: ''
${params.lib.optional (params.data.machine == "haseul") "
hash -d lts=/data/media
hash -d lts2=/data/media2
hash -d lts3=/data/media3
"}
hash -d dl="$HOME/Downloads"
hash -d p="$HOME/Projects"
''
