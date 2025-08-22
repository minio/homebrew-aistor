class Minio < Formula
  # minio specific
  git_tag = "RELEASE.2025-08-21T02-50-21Z"

  desc "High Performance Enterprise Object Storage compatible with Amazon S3 API"
  homepage "https://min.io/download?platform=macos"
  version git_tag
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minio/release/darwin-arm64/archive/minio.#{version}"
      sha256 "6f955a8b88ef2d7be07b52421384e93b4da3d35c709f60c4e857dbb66a4a9fc1"
    else
      url "https://dl.min.io/aistor/minio/release/darwin-amd64/archive/minio.#{version}"
      sha256 "54675dae46b1a5139ff188f6da48ad70f5bd28ec02e790a66bcc079cc2e93bd9"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minio/release/linux-arm64/archive/minio.#{version}"
      sha256 "e2a73e7e62e796b292d7e73c87b5f0c2bc81a7141875a9bce79e3437af030659"
    else
      url "https://dl.min.io/aistor/minio/release/linux-amd64/archive/minio.#{version}"
      sha256 "dd44fbf2d90622d13ed2f5b71a70eefd283596cb0ac4cc0e87bbb84ac30e5215"
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
      Talk to MinIO Engineering Support: https://subet.min.io
    EOS
    ohai "Get started:"
    puts `#{bin}/minio server -h`
  end
end
