package stx.config;

#if (sys || nodejs)
typedef DirectoryDef      = stx.config.term.Directory.DirectoryDef;
typedef Directory         = stx.config.term.Directory;


typedef FileDef           = stx.config.term.File.FileDef;
typedef File              = stx.config.term.File;
#end

typedef ResourceDef       = stx.config.term.Resource.ResourceDef;
typedef Resource          = stx.config.term.Resource;