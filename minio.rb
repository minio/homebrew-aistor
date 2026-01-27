class Minio < Formula
  # minio specific
  git_tag = "RELEASE.2025-12-20T04-58-37Z"

  desc "High Performance Enterprise Object Storage compatible with Amazon S3 API"
  homepage "https://min.io/download?platform=macos"
  version git_tag
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minio/release/darwin-arm64/archive/minio.#{version}"
      sha256 "12d9248c5170e87cc551712b14f8804a3605d245bf19bf3aeb0ee1a1c8da061d"
    else
      url "https://dl.min.io/aistor/minio/release/darwin-amd64/archive/minio.#{version}"
      sha256 "537d119ab52e16a341b0e1ed9b4ec8687411d0be15c4fa34c4b419a95f23db4e"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minio/release/linux-arm64/archive/minio.#{version}"
      sha256 "d8d3e09580ea1485f64be792e5e33b626ca24eaf4b79d008d23b803b12934ded"
    else
      url "https://dl.min.io/aistor/minio/release/linux-amd64/archive/minio.#{version}"
      sha256 "4d07910fa723e04cb38e3d0edf446fae2a306bc68439a060ee4f0d43f386dff7"
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
