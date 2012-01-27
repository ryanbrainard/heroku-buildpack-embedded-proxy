#!/bin/sh

. ${BUILDPACK_TEST_RUNNER_HOME}/lib/test_utils.sh

testNoDetect()
{
  detect

  assertNoAppDetected
}

testDetect_FilesExistButNotExecutable()
{
  mkdir -p ${BUILD_DIR}/.buildpack/bin
  touch ${BUILD_DIR}/.buildpack/bin/detect
  touch ${BUILD_DIR}/.buildpack/bin/compile
  touch ${BUILD_DIR}/.buildpack/bin/release

  detect

  assertNoAppDetected
}

testDetect_ExecutableFilesExistButEmpty()
{
  mkdir -p ${BUILD_DIR}/.buildpack/bin
  touch ${BUILD_DIR}/.buildpack/bin/detect
  touch ${BUILD_DIR}/.buildpack/bin/compile
  touch ${BUILD_DIR}/.buildpack/bin/release
  chmod +x ${BUILD_DIR}/.buildpack/bin/detect
  chmod +x ${BUILD_DIR}/.buildpack/bin/compile
  chmod +x ${BUILD_DIR}/.buildpack/bin/release
  
  detect

  assertEquals 1 ${RETURN}
}

testDetect_ExecutableFilesExist()
{
  mkdir -p ${BUILD_DIR}/.buildpack/bin
  cat > ${BUILD_DIR}/.buildpack/bin/detect <<EOF
echo "Detected" && exit 0
EOF
  touch ${BUILD_DIR}/.buildpack/bin/compile
  touch ${BUILD_DIR}/.buildpack/bin/release
  chmod +x ${BUILD_DIR}/.buildpack/bin/detect
  chmod +x ${BUILD_DIR}/.buildpack/bin/compile
  chmod +x ${BUILD_DIR}/.buildpack/bin/release
  
  detect

  assertAppDetected "Detected"
}
