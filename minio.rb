class Minio < Formula
  # minio specific
  git_tag = "RELEASE.2026-07-24T16-43-31Z"

  desc "High Performance Enterprise Object Storage compatible with Amazon S3 API"
  homepage "https://min.io/download?platform=macos"
  version git_tag
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minio/release/darwin-arm64/archive/minio.#{version}"
      sha256 "c9a0eb87e3c5927034e94255d399b84c89ae097ebf6ad4a507c93b8e0daf2e92"
    else
      url "https://dl.min.io/aistor/minio/release/darwin-amd64/archive/minio.#{version}"
      sha256 "937c3e17864e3851ceeb39e72dd8c4c8168673a8f94d088dfea5434105c654c9"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minio/release/linux-arm64/archive/minio.#{version}"
      sha256 "ffc52e0c29bf2574bf6069030b1069a058167edd1dfbe92a935bb37bef72dded"
    else
      url "https://dl.min.io/aistor/minio/release/linux-amd64/archive/minio.#{version}"
      sha256 "a1117e2aaae45eca5e7a7c470edd725ab98b82367ececa0d12a8ccd4773993ec"
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
      Talk to MinIO Engineering Support: https://subnet.min.io
    EOS
    ohai "Get started:"
    puts `#{bin}/minio server -h`
  end
end
