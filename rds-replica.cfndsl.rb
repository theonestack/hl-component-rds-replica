CloudFormation do

    component_name = external_parameters.fetch(:component_name, 'none').gsub('_','').gsub('-','')

    Condition("SourceRegionSet", FnNot(FnEquals(Ref(:SourceRegion), '')))

    RDS_DBInstance("#{component_name}Replica") do
        SourceDBInstanceIdentifier Ref(:SourceDBIdentifier)
        SourceRegion FnIf("SourceRegionSet", Ref(:SourceRegion), Ref('AWS::NoValue'))
        DBInstanceClass Ref(:ReplicaInstanceSize)
    end

end