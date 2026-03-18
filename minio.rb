class Minio < Formula
  # minio specific
  git_tag = "RELEASE.2026-03-17T21-25-16Z"

  desc "High Performance Enterprise Object Storage compatible with Amazon S3 API"
  homepage "https://min.io/download?platform=macos"
  version git_tag
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minio/release/darwin-arm64/archive/minio.#{version}"
      sha256 "6d0a3a3c009cb4caa3ca84b97889e4eb92d86927fe86e0022bf9b47da6edaa10"
    else
      url "https://dl.min.io/aistor/minio/release/darwin-amd64/archive/minio.#{version}"
      sha256 "dfbab43f25c8799215960c9de6b17c87a90e469960e42b94cd012fb50a5eac07"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minio/release/linux-arm64/archive/minio.#{version}"
      sha256 "208d8e1294b896db155addcb2fac740ee7c5f3fd1e0ac2e2439e494dc88098ab"
    else
      url "https://dl.min.io/aistor/minio/release/linux-amd64/archive/minio.#{version}"
      sha256 "8096d70c5fd55ba36bcbff2370d08ce6a44094ac7137c196e5aab2954f23dfbf"
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
