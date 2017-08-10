require 'spec_helper'

describe 'nxlog' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let :pre_condition do
        "class {'nxlog':
            conf_dir   => 'C:/nxlog/conf',
            conf_file  => 'nxlog.conf',
            nxlog_root => 'C:/nxlog',
          }"
      end

      it { is_expected.to contain_class('nxlog').with(
                      'ensure_setting'  => 'latest',
                      'input_execs'     => [],
                      'order_header'    => '01',
                      'order_extension' => '05',
                      'order_input'     => '10',
                      'order_output'    => '40',
                      'order_route'     => '90'
                  )
      }

      # Check that all classes are present
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('nxlog') }
      it { is_expected.to contain_class('nxlog::install') }
      it { is_expected.to contain_class('nxlog::config') }
      it { is_expected.to contain_class('nxlog::service') }
    end
  end
end
