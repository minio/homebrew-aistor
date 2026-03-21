class Minio < Formula
  # minio specific
  git_tag = "RELEASE.2026-03-20T23-11-32Z"

  desc "High Performance Enterprise Object Storage compatible with Amazon S3 API"
  homepage "https://min.io/download?platform=macos"
  version git_tag
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minio/release/darwin-arm64/archive/minio.#{version}"
      sha256 "7cfe85933e245080c42fc3c8a3c71cc179188d4548f14161fc72fa50380a8717"
    else
      url "https://dl.min.io/aistor/minio/release/darwin-amd64/archive/minio.#{version}"
      sha256 "7aff3baff7acd7bf75ce0995ef428435f392e1a6cdb9a8af37f3c28018011f17"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minio/release/linux-arm64/archive/minio.#{version}"
      sha256 "47f16ada97af59a1ea137c812e63fc0a5dfae5db84aba3d4ce1cf01294ff0b7f"
    else
      url "https://dl.min.io/aistor/minio/release/linux-amd64/archive/minio.#{version}"
      sha256 "7826111e667c16b6d4b1b6af65fa2ebc30ca1b1b61c42e390fea68d2dc2e13dd"
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
