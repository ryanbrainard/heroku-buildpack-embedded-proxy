#!/bin/sh

. ${BUILDPACK_TEST_RUNNER_HOME}/lib/test_utils.sh

testCompile()
{
  mkdir -p ${BUILD_DIR}/.buildpack/bin
  cat > ${BUILD_DIR}/.buildpack/bin/compile <<EOF
echo "Compiled"
EOF
  chmod +x ${BUILD_DIR}/.buildpack/bin/compile
  
  compile

  assertCapturedEquals "Compiled"
}
