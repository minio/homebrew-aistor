class Minio < Formula
  # minio specific
  git_tag = "RELEASE.2026-04-11T03-20-12Z"

  desc "High Performance Enterprise Object Storage compatible with Amazon S3 API"
  homepage "https://min.io/download?platform=macos"
  version git_tag
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minio/release/darwin-arm64/archive/minio.#{version}"
      sha256 "6ea654d14e6efcf857b7130e0fd4fb69dd3bd63d65c1a52dff3f3e238be62a06"
    else
      url "https://dl.min.io/aistor/minio/release/darwin-amd64/archive/minio.#{version}"
      sha256 "0acaed65dc3a2a713138d52675e0e78f542f6ec4b4da00e59ab6e8855e6615b3"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minio/release/linux-arm64/archive/minio.#{version}"
      sha256 "809dc91fa02dc5e3bf0391258a68d259b83c7f64a01459d7607db1ffb0bb0f61"
    else
      url "https://dl.min.io/aistor/minio/release/linux-amd64/archive/minio.#{version}"
      sha256 "f2f9c0bd41ad6fee7c16e52cca1c048dea2ad8058afc42bc0de688bc3e25cdc9"
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
