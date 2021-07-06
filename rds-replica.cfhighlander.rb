
CfhighlanderTemplate do
     
    Parameters do
      ComponentParam 'EnvironmentName', 'dev', isGlobal: true
      ComponentParam 'EnvironmentType', 'development', isGlobal: true

      ComponentParam 'SourceDBIdentifier'
      ComponentParam 'SourceRegion', ''
      ComponentParam 'ReplicaInstanceSize', 'db.t3.small'
      ComponentParam 'AllocatedStorage', ''
      ComponentParam 'MaxAllocatedStorage', ''

    end
  
  end