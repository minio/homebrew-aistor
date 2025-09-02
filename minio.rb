class Minio < Formula
  # minio specific
  git_tag = "RELEASE.2025-08-29T21-27-49Z"

  desc "High Performance Enterprise Object Storage compatible with Amazon S3 API"
  homepage "https://min.io/download?platform=macos"
  version git_tag
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minio/release/darwin-arm64/archive/minio.#{version}"
      sha256 "6c68752be947babd30b8bc57ab1bcad212358e5c3da420c2db4a201ced96d29b"
    else
      url "https://dl.min.io/aistor/minio/release/darwin-amd64/archive/minio.#{version}"
      sha256 "537d119ab52e16a341b0e1ed9b4ec8687411d0be15c4fa34c4b419a95f23db4e"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minio/release/linux-arm64/archive/minio.#{version}"
      sha256 "8445171622d189ae283fa653c86ea1b4e7b05fd7bb15623ab2453f27e19fe783"
    else
      url "https://dl.min.io/aistor/minio/release/linux-amd64/archive/minio.#{version}"
      sha256 "0221893004b0e50fb12e9d13fa469e6f38c88c0a0779e09e9bb4967d9f55ae06"
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
