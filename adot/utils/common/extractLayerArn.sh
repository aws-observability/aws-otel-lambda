# Running this script on Mac needs to install gnu-sed, else sed 's/[ ]//g;s/\|//g;s/^$region//'
region=${AWS_REGION-$(aws configure get region)}
releaseNote='release-note.md'
if [ $# -ge 0 ]; then
  releaseNote=$1
fi
cat $releaseNote | grep $region | sed -e 's/[ ]//g;s/\||//g;s/^$region//'