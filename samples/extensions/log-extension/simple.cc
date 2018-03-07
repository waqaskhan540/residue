#include "simple.h"
#include <iostream>

RESIDUE_EXTENSION(SimpleLogExtension, "1.0.0")

Extension::Result SimpleLogExtension::execute(void* d)
{
    LogExtension::Data* data = static_cast<LogExtension::Data*>(d);
    if (!data) {
        writeLog("Data not passed in", Extension::LogLevel::Error);
        return {1, true};
    }
    writeLog("SimpleLogExtension->config->key: " + conf().get<std::string>("key", ""), Extension::LogLevel::Debug);
    std::cout << "SimpleLogExtension::execute() ==>" << data->formattedMessage << std::endl;
    return {0, true};
}
