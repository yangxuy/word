import { Ability, AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { kvStore } from '../pages/database/kvStore';
import { buffer } from '@kit.ArkTS';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    kvStore.init(this)
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    windowStage.loadContent("pages/Index", async (err) => {
      AppStorage.setOrCreate("windowStage", windowStage);
      let windowClass: window.Window = windowStage.getMainWindowSync();
      windowClass.setSpecificSystemBarEnabled('navigationIndicator', false)

      let type = window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR; // 以导航条避让为例
      let avoidArea = windowClass.getWindowAvoidArea(type);
      let bottomRectHeight = avoidArea.bottomRect.height; // 获取到导航条区域的高度
      AppStorage.setOrCreate('bottomHeight', px2vp(bottomRectHeight));

      type = window.AvoidAreaType.TYPE_SYSTEM; // 以状态栏避让为例
      avoidArea = windowClass.getWindowAvoidArea(type);
      let topRectHeight = avoidArea.topRect.height; // 获取状态栏区域高度
      AppStorage.setOrCreate('topHeight', topRectHeight);

      windowClass.on('avoidAreaChange', (data) => {
        if (data.type === window.AvoidAreaType.TYPE_SYSTEM) {
          let topRectHeight = data.area.topRect.height;
          AppStorage.setOrCreate('topHeight', topRectHeight);
        } else if (data.type == window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR) {
          let bottomRectHeight = data.area.bottomRect.height;
          AppStorage.setOrCreate('bottomHeight', bottomRectHeight);
        }
      });

      let data: Uint8Array = getContext(this).resourceManager.getRawFileContentSync("word.json");
      const json = buffer.from(data.buffer).toString('utf-8');
      AppStorage.setOrCreate("jsonWord", JSON.parse(json));

      // 已经学习的单词
      PersistentStorage.persistProp('learnIdx', []);
      // 不认识的单词
      PersistentStorage.persistProp('unknownIdx', []);
      // 今天学习时间和时长
      PersistentStorage.persistProp('learnDay', {
        time: 0,
        word: '',
        duration: 0,
        timer: 0
      });
      // 账户存储
      PersistentStorage.persistProp('userPhone', "游客模式");
    });
  }
}