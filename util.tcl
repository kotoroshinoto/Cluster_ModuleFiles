proc checkBin {name version {prefix ""}} {
	if {[string compare $prefix "" ] == 0} {
		set path "$name/$version"
	} else {
		set path "$prefix/$name/$version"
	}
	if {[file exists "$path/bin"] && [file isdirectory "$path/bin"]} {
		prepend-path PATH "$path/bin"
		if {[info exists ::env(MODULES_DEBUG)] == 1 &&  [ module-info mode load ] } { puts stderr "$path/bin added to environmental variable: PATH" }
	} else {
		if {[info exists ::env(MODULES_DEBUG)] == 1 &&  [ module-info mode load ] } { puts stderr "failed to find $path/bin" }
	}
	return
}

proc checkInclude {name version {prefix ""}} {
	if {[string compare $prefix "" ] == 0} {
		set path "$name/$version"
	} else {
		set path "$prefix/$name/$version"
	}
	if {[file exists "$path"] && [file isdirectory "$path"]} {
		prepend-path CPLUS_INCLUDE_PATH "$path/include"
		prepend-path C_INCLUDE_PATH "$path/include"
		if {[info exists ::env(MODULES_DEBUG)] == 1 &&  [ module-info mode load ] } { puts stderr "$path/include added to environmental variables: CPLUS_INCLUDE_PATH, C_INCLUDE_PATH" }
	
	} else {
		if {[info exists ::env(MODULES_DEBUG)] == 1 &&  [ module-info mode load ] } { puts stderr "failed to find $path" }
	}
	return
	
}

proc checkLib {name version {prefix ""}} {
	if {[string compare $prefix "" ] == 0} {
		set path "$name/$version"
	} else {
		set path "$prefix/$name/$version"
	}
	if {[file exists "$path"] && [file isdirectory "$path"]} {
		prepend-path LD_LIBRARY_PATH "$path/lib"
		prepend-path LIBRARY_PATH "$path/lib"
		prepend-path LD_RUN_PATH "$path/lib"
		if {[info exists ::env(MODULES_DEBUG)] == 1 &&  [ module-info mode load ] } { puts stderr "$path/lib added to environmental variables: LD_LIBRARY_PATH, LIBRARY_PATH, LD_RUN_PATH" }
	
	} else {
		if {[info exists ::env(MODULES_DEBUG)] == 1 &&  [ module-info mode load ] } { puts stderr "failed to find $path" }
	}
	return
	
}

proc checkLib64 {name version {prefix ""}} {
	if {[string compare $prefix "" ] == 0} {
		set path "$name/$version"
	} else {
		set path "$prefix/$name/$version"
	}
	
	if {[file exists "$path"] && [file isdirectory "$path"]} {
		prepend-path LD_LIBRARY_PATH "$path/lib64"
		prepend-path LIBRARY_PATH "$path/lib64"
		prepend-path LD_RUN_PATH "$path/lib64"
		if {[info exists ::env(MODULES_DEBUG)] == 1 &&  [ module-info mode load ] } { puts stderr "$path/lib64 added to environmental variables: LD_LIBRARY_PATH, LIBRARY_PATH, LD_RUN_PATH" }
	} else {
		if {[info exists ::env(MODULES_DEBUG)] == 1 &&  [ module-info mode load ] } { puts stderr "failed to find $path" }
	}
	return
}

proc checkMAN {name version {prefix ""}} {
	if {[string compare $prefix "" ] == 0} {
		set path "$name/$version"
	} else {
		set path "$prefix/$name/$version"
	}
	if {[file exists "$path/man"] && [file isdirectory "$path/man"]} {
		prepend-path MANPATH "$path/man"
		if {[info exists ::env(MODULES_DEBUG)] == 1 &&  [ module-info mode load ] } { puts stderr "$path/man added to environmental variable: MANPATH" }
	} else {
		if {[info exists ::env(MODULES_DEBUG)] == 1 &&  [ module-info mode load ] } { puts stderr "failed to find $path/man" }
	}
	if {[file exists "$path/share/man"] && [file isdirectory "$path/share/man"]} {
		prepend-path MANPATH "$path/share/man"
		if {[info exists ::env(MODULES_DEBUG)] == 1 &&  [ module-info mode load ] } { puts stderr "$path/share/man added to environmental variable: MANPATH" }
	} else {
		if {[info exists ::env(MODULES_DEBUG)] == 1 &&  [ module-info mode load ] } { puts stderr "failed to find $path/share/man" }
	}
	return
}


proc checkINFO { name version {prefix ""} } {
	if {[string compare $prefix "" ] == 0} {
		set path "$name/$version/share/info"
	} else {
		set path "$prefix/$name/$version/share/info"
	}
	if {[file exists "$path"] && [file isdirectory "$path"]} {
		prepend-path INFOPATH "$path"
		if {[info exists ::env(MODULES_DEBUG)] == 1 &&  [ module-info mode load ] } { puts stderr "$path added to environmental variable: INFOPATH" }
	} else {
		if {[info exists ::env(MODULES_DEBUG)] == 1 &&  [ module-info mode load ] } { puts stderr "failed to find $path" }
	}
	return
}

proc checkPKGCONFIG { name version {prefix ""} } {
	if {[string compare $prefix "" ] == 0} {
		set path "$name/$version"
	} else {
		set path "$prefix/$name/$version"
	}
	
	if {[file exists "$path/lib/pkgconfig"] && [file isdirectory "$path/lib/pkgconfig"]} {
		prepend-path PKG_CONFIG_PATH "$path/lib/pkgconfig"
		if {[info exists ::env(MODULES_DEBUG)] == 1 &&  [ module-info mode load ] } { puts stderr "$path/lib/pkgconfig added to environmental variable: PKG_CONFIG_PATH" }
	} else {
		if {[info exists ::env(MODULES_DEBUG)] == 1 &&  [ module-info mode load ] } { puts stderr "failed to find $path/lib/pkgconfig" }
	}
	
	if {[file exists "$path/lib64/pkgconfig"] && [file isdirectory "$path/lib64/pkgconfig"]} {
		prepend-path PKG_CONFIG_PATH "$path/lib64/pkgconfig"
		if {[info exists ::env(MODULES_DEBUG)] == 1 &&  [ module-info mode load ] } { puts stderr "$path/lib64/pkgconfig added to environmental variable: PKG_CONFIG_PATH" }
	} else {
		if {[info exists ::env(MODULES_DEBUG)] == 1 &&  [ module-info mode load ] } { puts stderr "failed to find $path/lib64/pkgconfig" }
	}
}

proc checkStandardPaths {name version {prefix ""} } {
#	puts stderr "Checking_STD_PATHS"
	checkBin $name $version $prefix
#	puts stderr "BIN CHECKED"
	checkInclude $name $version $prefix
#	puts stderr "INCLUDE CHECKED"
	checkLib $name $version $prefix
#	puts stderr "LIB CHECKED"
	checkLib64 $name $version $prefix
#	puts stderr "LIB64 CHECKED"
	checkMAN $name $version $prefix
#	puts stderr "MAN CHECKED"
	checkINFO $name $version $prefix
#	puts stderr "INFO_CHECKED"
	checkPKGCONFIG $name $version $prefix
#	puts stderr "PKGCONFIG_CHECKED"
}

proc dependsOn {modulename} {
	if { ! (is-loaded $modulename) } {
		module load $modulename
	}
	prereq $modulename
}
