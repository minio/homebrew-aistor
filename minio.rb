class Minio < Formula
  # minio specific
  git_tag = "RELEASE.2026-09-07T08-39-31Z"

  desc "High Performance Enterprise Object Storage compatible with Amazon S3 API"
  homepage "https://min.io/download?platform=macos"
  version git_tag
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minio/release/darwin-arm64/archive/minio.#{version}"
      sha256 "5c7edd0bab341a94b18da4b24e76c1b5a9272f67d015a643d48fd0e3618c54a0"
    else
      url "https://dl.min.io/aistor/minio/release/darwin-amd64/archive/minio.#{version}"
      sha256 "95a0f67e2104c28cb6a2d008fa6e49f0d5946bc1ba714d4fa1da21c1e26983f9"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minio/release/linux-arm64/archive/minio.#{version}"
      sha256 "8667dbae348167a71dd686177845c09bd033b4fbed155fa2bb5b2ad4f67e5644"
    else
      url "https://dl.min.io/aistor/minio/release/linux-amd64/archive/minio.#{version}"
      sha256 "f62b67211cb8c19bb37aa5f318b8842987b261b7f0e985df61a5fe30707e7827"
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
