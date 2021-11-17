module CIHelper

    GITHUB_TOKEN = ENV['GITHUB_TOKEN']

    if ENV['PX_BITRISE_CI']
        LIB_NAME = ENV['PX_BITRISE_LIB_NAME']
        MERGE_BRANCH = ENV['BITRISE_GIT_BRANCH']
        BUILD_DIR = ENV['BITRISE_SOURCE_DIR']
        SCHEME = ENV['PX_BITRISE_SCHEME']
        TEST_SCHEME = ENV['PX_BITRISE_TEST_SCHEME']
    end

    def self.is_release_branch?
        return CIHelper::MERGE_BRANCH.match?(/^release\/([0-9])+\.([0-9])+\.([0-9])+$/)
    end

    def self.get_lib_version
        return CIHelper::MERGE_BRANCH.match(/release\/(.*)/)[1]
    end

    def self.get_spec_version
        require 'cocoapods'

        podspec_path = "#{CIHelper::BUILD_DIR}/#{CIHelper::LIB_NAME}.podspec"
        spec = Pod::Specification.from_file(podspec_path)
        spec.version.to_s()
    end

end