require 'spec_helper'

describe 'nxlog' do
  let :facts do
    {
      kernel: 'windows',
      osfamily: 'windows',
      operatingsystem: 'windows',
      concat_basedir: File.join(Puppet[:vardir], 'concat'),
    }
  end

  let :pre_condition do
    "class {'nxlog':
        conf_dir   => 'C:/nxlog/conf',
        conf_file  => 'nxlog.conf',
        nxlog_root => 'C:/nxlog',
      }"
  end

  it {
    is_expected.to contain_class('nxlog').with(
      'ensure_setting'  => 'latest',
      'input_execs'     => [],
      'order_header'    => '01',
      'order_extension' => '05',
      'order_input'     => '10',
      'order_output'    => '40',
      'order_route'     => '90',
    )
  }

  # Check that all classes are present
  it { is_expected.to contain_class('nxlog::params') }
  it { is_expected.to contain_anchor('nxlog::start') }
  it { is_expected.to contain_class('nxlog::install') }
  it { is_expected.to contain_class('nxlog::config') }
  it { is_expected.to contain_class('nxlog::service') }
  it { is_expected.to contain_anchor('nxlog::end') }
end
