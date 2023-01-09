-- jdtls vim

local config = {
	cmd = { "jdtls" },
	root_dir = vim.fs.dirname(vim.fs.find({'.gradlew', '.git', 'mvnw'}, { upward = true })[1]),
	settings = {
		java = {
			configuration = {
				runtimes = {
					{
						name = 'JavaSE-17',
						path = '/usr/lib/jvm/jdk-19+fx-19/',
					},
				},
			},
		},
	},
}

require('jdtls').start_or_attach(config)
