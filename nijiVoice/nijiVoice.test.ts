import { NijiVoice } from './nijiVoice';

/**
 * にじボイスAPIのE2Eテスト
 * 音声合成のリクエストを送信し、生成された音声のURLを取得します
 */
const testNijiVoiceGeneration = async () => {
    console.info('🚀 === にじボイス音声合成テスト ===');
    console.info('ℹ️ テスト内容:');
    console.info('  1. テキストから音声を生成');
    console.info('  2. 生成された音声のURLを取得');
    console.info('==================');
    console.info('✨ テストを開始します...\n');

    // NijiVoiceインスタンスを作成
    const nijiVoice = new NijiVoice("{YOUR_API_KEY}");

    // リクエストを作成して音声を生成
    try {
        const response = await nijiVoice.generateVoice(
            NijiVoice.voiceActors.mito_asuna,
            {
                script: '春休みさいこー！',
                speed: '1.0',
            },
        );

        // 結果を表示
        console.log(); // 改行を入れて見やすく
        console.info('📝 === 生成結果 ===');
        console.info(`🔊 音声URL: ${response.generatedVoice.audioFileUrl}`);
        console.info(`⬇️ ダウンロードURL: ${response.generatedVoice.audioFileDownloadUrl}`);
        console.info('=====================\n');

        console.info('✨ テストが完了しました\n');
        return response;
    } catch (error) {
        console.error('❌ テスト実行中にエラーが発生しました:', error);
        throw error;
    }
};

// メイン処理
if (require.main === module) {
    testNijiVoiceGeneration().catch((error) => {
        console.error('❌ テストが失敗しました:', error);
        process.exit(1);
    });
}
