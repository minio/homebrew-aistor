class Minio < Formula
  # minio specific
  git_tag = "RELEASE.2025-06-27T22-30-56Z"

  desc "High Performance Enterprise Object Storage compatible with Amazon S3 API"
  homepage "https://min.io/download?platform=macos"
  version git_tag
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minio/release/darwin-arm64/archive/minio.#{version}"
      sha256 "458c59fc9315cfeeed97bfcd9d0357ca51fd52f6b90db0cbf3d6ca47af141af4"
    else
      url "https://dl.min.io/aistor/minio/release/darwin-amd64/archive/minio.#{version}"
      sha256 "f97954fc1c3474ebb2e45d280fc655679f1e5b5284be0f81163f0f64a09eb9cc"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minio/release/linux-arm64/archive/minio.#{version}"
      sha256 "f4abee5427a6bc50c6fa3a8bc1779770193be7833e61d425be019e4bfffd6363"
    else
      url "https://dl.min.io/aistor/minio/release/linux-amd64/archive/minio.#{version}"
      sha256 "0d0924e379348a62d01e76a9f0c7d8bb5c7eec8d04612b294fdb1dd51be8ac62"
    end
  end

  def install
    bin.install Dir.glob("minio.*").first => "minio"
  end

  def post_install
    ohai "Download complete!"
    ohai "Useful links:"
    puts <<~EOS
      Documentation: https://docs.min.io/enterprise/aistor-object-store/
      Talk to MinIO Engineering Support: https://subet.min.io
    EOS
    ohai "Get started:"
    puts `#{bin}/minio server -h`
  end
end
