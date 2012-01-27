#!/bin/sh

. ${BUILDPACK_TEST_RUNNER_HOME}/lib/test_utils.sh

testNoDetect()
{
  detect

  assertNoAppDetected
}

testDetect_FilesExistButNotExecutable()
{
  mkdir ${BUILD_DIR}/.buildpack
  touch ${BUILD_DIR}/.buildpack/detect
  touch ${BUILD_DIR}/.buildpack/compile
  touch ${BUILD_DIR}/.buildpack/release

  detect

  assertNoAppDetected
}

testDetect_ExecutableFilesExistButEmpty()
{
  mkdir ${BUILD_DIR}/.buildpack
  touch ${BUILD_DIR}/.buildpack/detect
  touch ${BUILD_DIR}/.buildpack/compile
  touch ${BUILD_DIR}/.buildpack/release
  chmod +x ${BUILD_DIR}/.buildpack/detect
  chmod +x ${BUILD_DIR}/.buildpack/compile
  chmod +x ${BUILD_DIR}/.buildpack/release
  
  detect

  assertEquals 1 ${RETURN}
}

testDetect_ExecutableFilesExist()
{
  mkdir ${BUILD_DIR}/.buildpack
  cat > ${BUILD_DIR}/.buildpack/detect <<EOF
echo "Detected" && exit 0
EOF
  touch ${BUILD_DIR}/.buildpack/compile
  touch ${BUILD_DIR}/.buildpack/release
  chmod +x ${BUILD_DIR}/.buildpack/detect
  chmod +x ${BUILD_DIR}/.buildpack/compile
  chmod +x ${BUILD_DIR}/.buildpack/release
  
  detect

  assertAppDetected "Detected"
}
