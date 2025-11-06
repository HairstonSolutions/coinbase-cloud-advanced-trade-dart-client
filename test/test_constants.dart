import 'dart:io';

final Map<String, String> envVars = Platform.environment;
final String apiKeyName = envVars['COINBASE_API_KEY_NAME'] ?? 'api_key_name';
final String privateKeyPEM = envVars['COINBASE_PRIVATE_KEY'] ??
    '''-----BEGIN EC PRIVATE KEY-----
MHcCAQEEIC7MfY+wECbErLMx+7w87cWuAs6tdm505p9yGfEaxqVfoAoGCCqGSM49
AwEHoUQDQgAEoUiHOzjV7KODS686wHTYwY/gz5dvPKjVS/maWU+VKcuNBUvAc5hj
hSHpKl+DhF2u09WahshD18zlBVqFGO46Fg==
-----END EC PRIVATE KEY-----''';
final String? skipTests = envVars['SKIP_TESTS'];
final bool ciSkip = skipTests == 'false' ? false : true;
