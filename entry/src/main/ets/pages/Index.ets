import { DictionaryPage } from './children/dictionary';
import { HomePage } from './children/home';
import { MePage } from './children/me';
import { Exam } from './exam';
import { Learn } from './Learn';
import { WordSearch } from './WordSearch';

@Entry
@Component
struct Index {
  private controller: TabsController = new TabsController(); // 初始化Tab控制器
  @State currentIndex: number = 0;
  @StorageProp("bottomHeight") bottomHeight: number = 0;
  @Provide navStack: NavPathStack = new NavPathStack()

  @Builder
  tabBuilder(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(selectedImg)
        .fillColor(this.currentIndex === targetIndex ? '#000' : '#6B6B6B')
        .size({ width: 18, height: 18 })
        .margin({
          bottom: 4
        })
      Text(title)
        .fontSize(14)
        .fontColor(this.currentIndex === targetIndex ? '#000' : '#6B6B6B')
    }
    .padding({
      top: 10,
      bottom: this.bottomHeight
    })
    .backgroundColor("#fff")
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  PageMap(name: string) {
    if (name == 'learn') {
      Learn()
    }else if(name=='exam'){
      Exam()
    }else if(name='search'){
      WordSearch()
    }
  }

  build() {
    Navigation(this.navStack) {
      Tabs({ barPosition: BarPosition.End, index: this.currentIndex, controller: this.controller }) {
        TabContent() {
          HomePage()
        }
        .tabBar(this.tabBuilder('单词本', 0, $r('app.media.word'), $r('app.media.word')))

        TabContent() {
          DictionaryPage()
        }
        .tabBar(this.tabBuilder('单词本', 1, $r('app.media.find'), $r('app.media.find')))

        TabContent() {
          MePage()
        }
        .tabBar(this.tabBuilder('单词本', 2, $r('app.media.user'), $r('app.media.user')))
      }
      .height('100%')
      .scrollable(false)
      .animationMode(AnimationMode.NO_ANIMATION)
      .onChange((index: number) => {
        this.currentIndex = index
      })
      .vertical(false)
      .scrollable(false)
      .layoutWeight(1)
      .barHeight(78)
    }
    .height('100%')
    .hideTitleBar(true)
    .backgroundColor('#F8F9FB')
    .backgroundImage($r('app.media.person_bg'))
    .mode(NavigationMode.Stack)
    .navDestination(this.PageMap)
  }
}