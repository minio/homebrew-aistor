class Minio < Formula
  # minio specific
  git_tag = "RELEASE.2026-09-19T17-05-25Z"

  desc "High Performance Enterprise Object Storage compatible with Amazon S3 API"
  homepage "https://min.io/download?platform=macos"
  version git_tag
  revision 1

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minio/release/darwin-arm64/archive/minio.#{version}"
      sha256 "1cf3586c1987f318d31869a00aef9a9608eaa0e22a0722004924b76450f1bb8e"
    else
      url "https://dl.min.io/aistor/minio/release/darwin-amd64/archive/minio.#{version}"
      sha256 "f587918f8c20bf63de8a4d900b521ad7af6f4c3319fabfac0e35d3f9fdec242d"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://dl.min.io/aistor/minio/release/linux-arm64/archive/minio.#{version}"
      sha256 "e2c132738afa72f2c2b368d783c81460ad8f79aa00b190162d7a3c6c12e99766"
    else
      url "https://dl.min.io/aistor/minio/release/linux-amd64/archive/minio.#{version}"
      sha256 "bc7c22c306f18af89726c44200f4f0bb35c93cab6a67ce5cb8ba76b322f18aca"
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
