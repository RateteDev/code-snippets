import { z } from 'zod';

/**
 * NijiVoice APIクライアントクラス
 * 音声合成のリクエストと生成を管理します
 */
export class NijiVoice {
    /**
     * 利用可能な声優ID
     * @see https://platform.nijivoice.com/characters
     */
    public static readonly voiceActors = {
        lapis: '47abf5ad-5336-4ace-9254-c145590a9576',
        takatsuki_riko: '8c08fd5b-b3eb-4294-b102-a1da00f09c72',
        mito_asuna: 'dba2fa0e-f750-43ad-b9f6-d5aeaea7dc16'
        // 必要に応じて追加
    };

    /**
     * NijiVoice APIのパラメータの型定義
     * @description NijiVoice APIで音声を生成する際に必要なパラメータの型を定義します
     * @see {@link https://docs.nijivoice.com/reference/postv1voiceactorsidgeneratevoice} NijiVoice API リファレンス
     * @field script - [必須]読み上げるテキスト。3,000文字まで。<sp>や<wait>タグで速度や間を制御可能
     * @field speed - [必須]読み上げ速度。0.4から3.0の範囲で指定
     * @field emotionalLevel - [任意]感情レベル。0から1.5の範囲で指定。未指定時は推奨値を使用
     * @field soundDuration - [任意]音素の発音の長さ。0から1.7の範囲で指定。未指定時は推奨値を使用
     * @field format - [任意]音声の形式。mp3かwavを指定。デフォルトはmp3
     */
    private static readonly requestSchema = z.object({
        /*
         * 読み上げるテキスト(必須)
         * 音声を合成するテキスト
         * 3,000文字まで一度に生成可能
         * <sp 1.0>xxxのようにタグで囲むことで、タグ内のテキストのスピードを変更することができる
         * <wait 0.3>のようにタグを入れると、入力した秒数分だけ間を挿入することができる
         */
        script: z.string().min(1, "テキストを入力してください"),

        /*
         * 読み上げのスピード(必須)
         * 0.4 ~ 3.0
         */
        speed: z.string().refine(
            (val) => {
                const num = parseFloat(val);
                return num >= 0.4 && num <= 3.0;
            },
            { message: "速度は0.4から3.0の間で指定してください" }
        ),

        /*
         * 感情レベル(任意)
         * 0 ~ 1.5
         * 音声の感情的な変動を制御
         * 値が小さいほど滑らかに、大きいほど感情豊かに
         * 未指定の場合は、指定したVoice Actorの感情レベルの推奨値が使用される
         */
        emotionalLevel: z.string().optional().refine(
            (val) => {
                if (!val) return true;
                const num = parseFloat(val);
                return num >= 0 && num <= 1.5;
            },
            { message: "感情レベルは0から1.5の間で指定してください" }
        ),

        /*
         * 音素の発音の長さ(任意)
         * 0 ~ 1.7
         * 値が小さいほど短く、大きいほど長く
         * 未指定の場合は、指定したVoice Actorの音素の発音の長さの推奨値が使用される
         */
        soundDuration: z.string().optional().refine(
            (val) => {
                if (!val) return true;
                const num = parseFloat(val);
                return num >= 0 && num <= 1.7;
            },
            { message: "音声の長さは0から1.5の間で指定してください" }
        ),

        /*
         * 音声の形式(任意)
         * mp3 or wav
         * デフォルトはmp3
         */
        format: z.enum(['mp3', 'wav']).optional()
    });

    private readonly apiKey: string;
    private readonly baseUrl: string = 'https://api.nijivoice.com/api/platform/v1';

    /**
     * @param apiKey - NijiVoice APIキー
     */
    constructor(apiKey: string) {
        this.apiKey = apiKey;
    }

    /**
     * 音声を生成する
     * @param request - 音声生成リクエストパラメータ
     * @param voiceActorId - 声優ID
     * @returns 生成された音声のURL情報
     * @example
     * ```typescript
     * const nijiVoice = new NijiVoice(apiKey);
     * const request = {
     *   script: 'こんにちは',
     *   speed: '1.0'
     * };
     * const response = await nijiVoice.generateVoice(request, NijiVoice.voiceActors.mito_asuna);
     * console.log(response.generatedVoice.audioFileUrl);
     * ```
     */
    public async generateVoice(
        voiceActorId: string,
        request: z.infer<typeof NijiVoice.requestSchema>,
    ) {
        // リクエストのバリデーション
        NijiVoice.requestSchema.parse(request);

        const options = {
            method: 'POST',
            headers: {
                accept: 'application/json',
                'content-type': 'application/json',
                'x-api-key': this.apiKey
            },
            body: JSON.stringify({
                script: request.script,
                speed: request.speed,
                emotionalLevel: request.emotionalLevel,
                soundDuration: request.soundDuration,
                format: request.format
            })
        };

        const url = `${this.baseUrl}/voice-actors/${voiceActorId}/generate-voice`;
        const response = await fetch(url, options);

        if (!response.ok) {
            throw new Error(`❌ HTTP error! status: ${response.status}`);
        }

        const data = await response.json();

        return data;
    }
}

