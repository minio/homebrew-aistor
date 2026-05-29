class Minio < Formula
  # minio specific
  git_tag = "RELEASE.2026-05-28T20-50-32Z"

  desc "High Performance Enterprise Object Storage compatible with Amazon S3 API"
  homepage "https://min.io/download?platform=macos"
  version git_tag
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minio/release/darwin-arm64/archive/minio.#{version}"
      sha256 "3a9c3ef8749e2976eaab021f7e704b94dde325fbc9ad42d4047c781b2c94dfb2"
    else
      url "https://dl.min.io/aistor/minio/release/darwin-amd64/archive/minio.#{version}"
      sha256 "0b23077f44c1cf714e04130172da452010fa7680de8c8c2ca0053500289007d3"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minio/release/linux-arm64/archive/minio.#{version}"
      sha256 "544124dc0a65fe4227544acd50ae5f54c5bb6125ebad271ffa89584ab655c991"
    else
      url "https://dl.min.io/aistor/minio/release/linux-amd64/archive/minio.#{version}"
      sha256 "b7684ab57418aa2e846dd578598d204dcacc73d42d842277173469d6ab45eb77"
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
