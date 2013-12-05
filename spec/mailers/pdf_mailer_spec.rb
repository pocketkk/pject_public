require 'spec_helper'
require 'carrierwave/test/matchers'

describe PdfMailer do

    include CarrierWave::Test::Matchers

    before do
        PdfdocUploader.enable_processing = true
        @document = FactoryGirl.build(:document)
    end

    after do
        PdfdocUploader.enable_processing = false
    end

    it "has a valid factory" do
        @document.class.name.should == "Document"
    end

    it "has a valid factory that is a valid document" do
        # @document.new_update
        # Document.all.count.should == 1
    end

end
