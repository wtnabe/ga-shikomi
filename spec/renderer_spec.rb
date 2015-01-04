require_relative 'spec_helper'

module GACli
  describe Renderer do
    include MetadataDouble

    describe '#table' do
      describe '--verbose' do
        it {
          Renderer.new(metadata_double, :format => 'table', :verbose => true).render_metadata
        }
      end
      describe 'picked' do
        it {
          Renderer.new(metadata_double, :format => 'table').render_metadata
        }
      end
    end

    describe '#csv' do
      it {
        Renderer.new(metadata_double, :format => 'csv').render_metadata
      }
    end
  end

  describe '#render_ga' do
    include GaDouble
    it {
      Renderer.new(multi_rows, {}).render_ga
    }
  end
end

