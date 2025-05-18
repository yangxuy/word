import { UIAbility } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

export default class EntryAbility extends UIAbility {
  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    windowStage.loadContent('pages/Index', (err) => {
      // 存储学生情况
      AppStorage.setOrCreate("user", {
        studentName: "陈思远",
        studentNo: "2023114514",
        studentDepart: "计算机科学与技术学院"
      })
      let windowClass: window.Window = windowStage.getMainWindowSync();
      windowClass.setWindowLayoutFullScreen(true)

      const type = window.AvoidAreaType.TYPE_SYSTEM; // 以状态栏避让为例
      const avoidArea = windowClass.getWindowAvoidArea(type);
      let topRectHeight = avoidArea.topRect.height; // 获取状态栏区域高度
      AppStorage.setOrCreate('topHeight', px2vp(topRectHeight));
    });
  }
}