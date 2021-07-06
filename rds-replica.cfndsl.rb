CloudFormation do

    component_name = external_parameters.fetch(:component_name, 'none').gsub('_','').gsub('-','')

    tags = []
    tags << { Key: 'Environment', Value: Ref(:EnvironmentName) }
    tags << { Key: 'EnvironmentType', Value: Ref(:EnvironmentType) }
  
    extra_tags = external_parameters.fetch(:extra_tags, {})
    extra_tags.each { |key,value| tags << { Key: key, Value: value } }

    Condition("SourceRegionSet", FnNot(FnEquals(Ref(:SourceRegion), '')))
    Condition("MaxAllocatedStorageSet", FnNot(FnEquals(Ref(:MaxAllocatedStorage), '')))
    Condition("AllocatedStorageSet", FnNot(FnEquals(Ref(:AllocatedStorage), '')))

    RDS_DBInstance("#{component_name}Replica") do
      DBInstanceIdentifier FnSub(external_parameters[:db_instance_name]) unless external_parameters[:db_instance_name].nil?
      SourceDBInstanceIdentifier Ref(:SourceDBIdentifier)
      SourceRegion FnIf("SourceRegionSet", Ref(:SourceRegion), Ref('AWS::NoValue'))
      DBInstanceClass Ref(:ReplicaInstanceSize)
      AllocatedStorage FnIf("AllocatedStorageSet", Ref(:AllocatedStorage), Ref('AWS::NoValue'))
      MaxAllocatedStorage FnIf("MaxAllocatedStorageSet", Ref(:MaxAllocatedStorage), Ref('AWS::NoValue'))
      CopyTagsToSnapshot true
      Tags  tags + [
        { Key: 'Name', Value: FnJoin('-', [ Ref(:EnvironmentName), external_parameters[:component_name], 'replica' ])},
      ]
    end

end