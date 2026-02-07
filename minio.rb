class Minio < Formula
  # minio specific
  git_tag = "RELEASE.2026-02-07T07-43-34Z"

  desc "High Performance Enterprise Object Storage compatible with Amazon S3 API"
  homepage "https://min.io/download?platform=macos"
  version git_tag
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minio/release/darwin-arm64/archive/minio.#{version}"
      sha256 "6a1b3ea8270e2b90ac4c1e4ff90c02bdddfdad75944c13a305940921c43c70af"
    else
      url "https://dl.min.io/aistor/minio/release/darwin-amd64/archive/minio.#{version}"
      sha256 "20fc4660ef3d981ce31c3044fac562c73afd219078a34e9f7b047b260030b3a3"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minio/release/linux-arm64/archive/minio.#{version}"
      sha256 "efbb5cdb77e64bfa3c7fb550682a8877f2279527abe7696e75db6b4e1278f1dd"
    else
      url "https://dl.min.io/aistor/minio/release/linux-amd64/archive/minio.#{version}"
      sha256 "76df84e063348f249b02ecc25de410938f1603a791903c2778876148d2d3ccf9"
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
