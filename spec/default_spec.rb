require 'yaml'

describe 'should fail to validate with no resources' do
  
  context 'cftest' do
    it 'compiles test' do
      expect(system("cfhighlander cftest #{@validate} --tests tests/default.test.yaml")).to be_truthy
    end
  end

  let(:template) { YAML.load_file("#{File.dirname(__FILE__)}/../out/tests/default/rds-replica.compiled.yaml") }

  context 'Resource RDS Instance' do
    let(:properties) { template["Resources"]["rdsreplicaReplica"]["Properties"] }

    it 'has SourceDBInstanceIdentifier Ref' do
      expect(properties["SourceDBInstanceIdentifier"]).to eq({"Ref" => "SourceDBIdentifier"})
    end

    it 'has SourceRegion Ref' do
      expect(properties["SourceRegion"]).to eq({"Fn::If" => ["SourceRegionSet", {"Ref"=>"SourceRegion"}, {"Ref"=>"AWS::NoValue"}]})
    end

    it 'has DBInstanceClass Ref' do
      expect(properties["DBInstanceClass"]).to eq({"Ref" => "ReplicaInstanceSize"})
    end

    it 'has AllocatedStorage Ref' do
      expect(properties["AllocatedStorage"]).to eq({"Fn::If" => ["AllocatedStorageSet", {"Ref"=>"AllocatedStorage"}, {"Ref"=>"AWS::NoValue"}]})
    end

    it 'has MaxAllocatedStorage Ref' do
      expect(properties["MaxAllocatedStorage"]).to eq({"Fn::If" => ["MaxAllocatedStorageSet", {"Ref"=>"MaxAllocatedStorage"}, {"Ref"=>"AWS::NoValue"}]})
    end

    it 'has default tags' do
      expect(properties["Tags"]).to eq([
        {"Key"=>"Environment", "Value"=>{"Ref"=>"EnvironmentName"}},
        {"Key"=>"EnvironmentType", "Value"=>{"Ref"=>"EnvironmentType"}},
        {"Key"=>"Name",
          "Value"=>
            {"Fn::Join"=>
              ["-", [{"Ref"=>"EnvironmentName"}, "rds-replica", "replica"]]
            }
        }
      ])
    end

  end
  
end