#!/bin/sh

. ${BUILDPACK_TEST_RUNNER_HOME}/lib/test_utils.sh

testCompile()
{
  mkdir ${BUILD_DIR}/.buildpack
  cat > ${BUILD_DIR}/.buildpack/release <<EOF
echo "Released"
EOF
  chmod +x ${BUILD_DIR}/.buildpack/release
  
  release

  assertCapturedEquals "Released"
}
