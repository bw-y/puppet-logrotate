# logrotate

#### Table of Contents

1. [Overview](#overview)
2. [Usage - Configuration options and additional functionality](#usage)
3. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
4. [Limitations - OS compatibility, etc.](#limitations)

## Overview
目前仅写了tracker的日志切分的define，其它部分暂未开发

## Usage
在其它模块中调用时，如下
```
logrotate::tracker_rule { 'pro-log.conf':
  spath     => '/var/log/nginx/pro.access.log',
  dpath     => '/home/hadoop/pro_log_tar',
  cron_min  => '*/2',
}
```

## Reference

### Classes

* logrotate::base : 当logrotate包未在其它地方定义时，定义并确认其安装，tracker_rule默认引用

### Parameters

#### `logrotate::tracker_rule` ####

#### `spath`
要切分的日志文件的具体路径，必填项，不填则报错退出。  默认undef

#### `dpath`
日志切分后要放的目录，由于中转问题，因此会在此路径的最后一级目录的同级创建同名-tmp的文件，因此，此路径不得为一个单独挂载点根目录。  必填项，不填则报错退出。  默认undef

#### `ensure`
生成文件的状态和计划任务的状态，有效值: present(确认其存在)/absent(确认其删除)   默认值：present

#### `cron_min` and `cron_hour`
计划任务分钟和小时单位，有效值参考crontab语法。   默认值均为：*


## Limitations

