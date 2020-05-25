__gcloud_sdk_root="${GCLOUD_SDK_ROOT:-/usr/local/google-cloud-sdk}"

if [[ -d "${__gcloud_sdk_root}" ]]; then
  source "${__gcloud_sdk_root}/path.zsh.inc"
  source "${__gcloud_sdk_root}/completion.zsh.inc"
fi

unset __gcloud_sdk_root
