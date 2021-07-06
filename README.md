# RDS Read Replica CfHighlander component

![cftest](https://github.com/theonestack/hl-component-rds-replica/actions/workflows/cftest.yaml/badge.svg)

Creates the resources required to set up an RDS Read Replica

```bash
kurgan add rds-replica
```

## Parameters

| Name | Use | Default | Global | Type | Allowed Values |
| ---- | --- | ------- | ------ | ---- | -------------- |
| EnvironmentName | Tagging | dev | true | string
| EnvironmentType | Tagging | development | true | string | ['development','production']
| SourceDBIdentifier | The DB Identifer of the source DB | - | false | string
| SourceRegion | The source region of the read replica | - | false | string
| ReplicaInstanceSize | DB Instance class to use with this replica | - | false | string
