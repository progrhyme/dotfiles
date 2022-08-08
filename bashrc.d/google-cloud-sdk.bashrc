__gcloud_sdk_root="${GCLOUD_SDK_ROOT:-/usr/local/google-cloud-sdk}"

if [[ -d "${__gcloud_sdk_root}" ]]; then
  source "${__gcloud_sdk_root}/path.bash.inc"
  source "${__gcloud_sdk_root}/completion.bash.inc"
  export CLOUDSDK_PYTHON_SITEPACKAGES=1
fi

unset __gcloud_sdk_root
