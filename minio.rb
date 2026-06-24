class Minio < Formula
  # minio specific
  git_tag = "RELEASE.2026-06-06T02-44-06Z"

  desc "High Performance Enterprise Object Storage compatible with Amazon S3 API"
  homepage "https://min.io/download?platform=macos"
  version git_tag
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minio/release/darwin-arm64/archive/minio.#{version}"
      sha256 "d0c9c57ccdac1d68536d0c6467f026c1dd99b031132b8501456e82dc62364111"
    else
      url "https://dl.min.io/aistor/minio/release/darwin-amd64/archive/minio.#{version}"
      sha256 "09768f98f17f06b8b4854887cfd9b9df7d707424bb375f50172ab9fbd0dec8b5"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minio/release/linux-arm64/archive/minio.#{version}"
      sha256 "9cef6dd9eb0aa2b8ec83cc1df1eddd8fa8f6a09f6897a0712eb66275d7baa8af"
    else
      url "https://dl.min.io/aistor/minio/release/linux-amd64/archive/minio.#{version}"
      sha256 "3bfb61ecc7eef8661cbb4958bcb7ffc2f29c976c01bc0dbae3305d4761d7586a"
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
