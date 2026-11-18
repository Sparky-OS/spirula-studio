#pragma once
#include "i18n/BeginCatalog.h"

namespace spirula::i18n::msg::stereo {
SS_MSG(enable,
    EN("Enable 3D"), JA("3D を有効にする"), ZH_HANS("启用 3D"), ZH_HANT("啟用 3D"),
    KO("3D 사용"), DE("3D aktivieren"), FR("Activer la 3D"), ES("Activar 3D"),
    PT("Ativar 3D"), IT("Attiva 3D"), NL("3D inschakelen"), RU("Включить 3D"), TR("3B'yi etkinleştir"));
SS_MSG(resolution,
    EN("Render width per eye"), JA("片目あたりの描画幅"), ZH_HANS("每眼渲染宽度"), ZH_HANT("每眼算繪寬度"),
    KO("눈별 렌더링 너비"), DE("Renderbreite pro Auge"), FR("Largeur de rendu par œil"), ES("Ancho de renderizado por ojo"),
    PT("Largura de renderização por olho"), IT("Larghezza di rendering per occhio"), NL("Renderbreedte per oog"), RU("Ширина рендера для каждого глаза"), TR("Göz başına işleme genişliği"));
SS_MSG(display_settings,
    EN("Display Settings"), JA("ディスプレイ設定"), ZH_HANS("显示设置"), ZH_HANT("顯示設定"),
    KO("디스플레이 설정"), DE("Anzeigeeinstellungen"), FR("Configuration de l’affichage"), ES("Configuración de pantalla"),
    PT("Configurações de tela"), IT("Impostazioni dello schermo"), NL("Beeldscherminstellingen"), RU("Настройки экрана"), TR("Ekran ayarları"));
SS_MSG(no_limits,
    EN("No depth limits received. The two pictures are identical."), JA("奥行きの制限を受信していません。左右に同じ画像を表示します。"),
    ZH_HANS("未收到深度限制。双眼显示相同图像。"), ZH_HANT("未收到深度限制。雙眼顯示相同影像。"),
    KO("깊이 한도를 받지 못했습니다. 양쪽 눈에 같은 그림을 표시합니다."), DE("Keine Tiefengrenzen erhalten. Die Bilder sind identisch."),
    FR("Pas de limites de profondeur. Les images sont identiques."), ES("Sin límites de profundidad. Las imágenes son idénticas."),
    PT("Sem limites de profundidade. As imagens são idênticas."), IT("Limiti di profondità assenti. Le immagini sono identiche."),
    NL("Geen dieptegrenzen ontvangen. De beelden zijn gelijk."), RU("Нет пределов глубины. Изображения одинаковые."), TR("Derinlik sınırı alınmadı. İki resim de aynı."));
SS_MSG(zero_limits,
    EN("The two pictures are identical at these depth limits."), JA("現在の奥行きの制限では、左右に同じ画像を表示します。"),
    ZH_HANS("在当前深度限制下，双眼显示相同图像。"), ZH_HANT("在目前的深度限制下，雙眼顯示相同影像。"),
    KO("현재 깊이 한도에서는 양쪽 눈에 같은 그림을 표시합니다."), DE("Bei diesen Tiefengrenzen sind die Bilder identisch."),
    FR("Avec ces limites de profondeur, les images sont identiques."), ES("Con estos límites de profundidad, las imágenes son idénticas."),
    PT("Com estes limites de profundidade, as imagens são idênticas."), IT("Con questi limiti di profondità, le immagini sono identiche."),
    NL("Bij deze dieptegrenzen zijn de beelden gelijk."), RU("При этих пределах глубины изображения одинаковые."),
    TR("Bu derinlik sınırlarında iki resim de aynı."));
SS_MSG(no_support,
    EN("No finite scene depth. The two pictures are identical."), JA("有限のシーン深度を決定できません。左右に同じ画像を表示します。"),
    ZH_HANS("无法确定有限的场景深度。双眼显示相同图像。"), ZH_HANT("無法確定有限的場景深度。雙眼顯示相同影像。"),
    KO("유한한 장면 깊이를 구할 수 없습니다. 양쪽 눈에 같은 그림을 표시합니다."), DE("Keine endliche Szenentiefe. Die Bilder sind identisch."),
    FR("Profondeur non finie. Les images sont identiques."), ES("Profundidad no finita. Las imágenes son idénticas."),
    PT("Profundidade não finita. As imagens são idênticas."), IT("Profondità non finita. Le immagini sono identiche."),
    NL("Geen eindige scènediepte. De beelden zijn gelijk."), RU("Глубина сцены не конечна. Изображения одинаковые."), TR("Sahne derinliği sonlu değil. İki resim de aynı."));
SS_MSG(rectified,
    EN("3D rectifies this lens to a perspective view."), JA("3D 表示ではこのレンズを透視投影に変換します。"),
    ZH_HANS("3D 将此镜头校正为透视视图。"), ZH_HANT("3D 將此鏡頭校正為透視視圖。"),
    KO("3D에서는 이 렌즈를 원근 투영으로 보정합니다."), DE("3D entzerrt dieses Objektiv zu einer perspektivischen Ansicht."),
    FR("La 3D rectifie cet objectif en vue perspective."), ES("El 3D rectifica esta lente a una vista en perspectiva."),
    PT("O 3D retifica esta lente para uma vista em perspectiva."), IT("Il 3D rettifica questo obiettivo in una vista prospettica."),
    NL("3D rectificeert deze lens naar een perspectiefweergave."), RU("В 3D этот объектив преобразуется в перспективный вид."),
    TR("3B, bu merceği perspektif görünüme düzeltir."));
SS_MSG(allocation_failed,
    EN("Could not allocate the 3D view."), JA("3D 表示のメモリを確保できませんでした。"),
    ZH_HANS("无法为 3D 视图分配内存。"), ZH_HANT("無法為 3D 視圖配置記憶體。"),
    KO("3D 보기에 필요한 메모리를 할당하지 못했습니다."), DE("Speicher für die 3D-Ansicht konnte nicht reserviert werden."),
    FR("Impossible d’allouer la mémoire de la vue 3D."), ES("No se pudo asignar memoria para la vista 3D."),
    PT("Não foi possível alocar memória para a vista 3D."), IT("Impossibile allocare la memoria per la vista 3D."),
    NL("Kan geen geheugen voor de 3D-weergave reserveren."), RU("Не удалось выделить память для 3D-вида."),
    TR("3B görünüm için bellek ayrılamadı."));
SS_MSG(declaration_failed,
    EN("Could not declare the 3D view."), JA("3D 表示を宣言できませんでした。"),
    ZH_HANS("无法声明 3D 视图。"), ZH_HANT("無法宣告 3D 視圖。"),
    KO("3D 보기를 선언하지 못했습니다."), DE("Die 3D-Ansicht konnte nicht angemeldet werden."),
    FR("Impossible de déclarer la vue 3D."), ES("No se pudo declarar la vista 3D."),
    PT("Não foi possível declarar a vista 3D."), IT("Impossibile dichiarare la vista 3D."),
    NL("Kan de 3D-weergave niet aanmelden."), RU("Не удалось объявить 3D-вид."),
    TR("3B görünüm bildirilemedi."));
SS_MSG(session_required,
    EN("3D requires a Stereo KWin session."), JA("3D 表示には Stereo KWin セッションが必要です。"),
    ZH_HANS("3D 需要 Stereo KWin 会话。"), ZH_HANT("3D 需要 Stereo KWin 工作階段。"),
    KO("3D에는 Stereo KWin 세션이 필요합니다."), DE("3D erfordert eine Sitzung mit Stereo KWin."),
    FR("La 3D nécessite une session Stereo KWin."), ES("El 3D requiere una sesión de Stereo KWin."),
    PT("O 3D requer uma sessão do Stereo KWin."), IT("Il 3D richiede una sessione Stereo KWin."),
    NL("3D vereist een sessie met Stereo KWin."), RU("Для 3D нужен сеанс Stereo KWin."),
    TR("3B için Stereo KWin oturumu gerekir."));
SS_MSG(placement_failed,
    EN("Could not place the 3D view."), JA("3D 表示を配置できませんでした。"),
    ZH_HANS("无法放置 3D 视图。"), ZH_HANT("無法放置 3D 視圖。"),
    KO("3D 보기를 배치하지 못했습니다."), DE("Die 3D-Ansicht konnte nicht platziert werden."),
    FR("Impossible de placer la vue 3D."), ES("No se pudo colocar la vista 3D."),
    PT("Não foi possível posicionar a vista 3D."), IT("Impossibile posizionare la vista 3D."),
    NL("Kan de 3D-weergave niet plaatsen."), RU("Не удалось разместить 3D-вид."),
    TR("3B görünüm yerleştirilemedi."));
SS_MSG(pixel_format,
    EN("This window's pixel format cannot show 3D."), JA("このウィンドウのピクセル形式では 3D 表示ができません。"),
    ZH_HANS("此窗口的像素格式无法显示 3D。"), ZH_HANT("此視窗的像素格式無法顯示 3D。"),
    KO("이 창의 픽셀 형식으로 3D를 표시할 수 없습니다."), DE("Das Pixelformat dieses Fensters kann kein 3D anzeigen."),
    FR("Le format de pixels de cette fenêtre ne peut pas afficher la 3D."), ES("El formato de píxeles de esta ventana no permite mostrar 3D."),
    PT("O formato de pixels desta janela não permite exibir 3D."), IT("Il formato dei pixel di questa finestra non può mostrare il 3D."),
    NL("Het pixelformaat van dit venster kan geen 3D weergeven."), RU("Пиксельный формат этого окна не поддерживает 3D."),
    TR("Bu pencerenin piksel biçimi 3B gösteremiyor."));
SS_MSG(settings_failed,
    EN("Could not open Display Settings."), JA("ディスプレイ設定を開けませんでした。"), ZH_HANS("无法打开显示设置。"), ZH_HANT("無法開啟顯示設定。"),
    KO("디스플레이 설정을 열지 못했습니다."), DE("Anzeigeeinstellungen konnten nicht geöffnet werden."), FR("Impossible d’ouvrir la configuration de l’affichage."), ES("No se pudo abrir la configuración de pantalla."),
    PT("Não foi possível abrir as configurações de tela."), IT("Impossibile aprire le impostazioni dello schermo."), NL("Kan de beeldscherminstellingen niet openen."), RU("Не удалось открыть настройки экрана."), TR("Ekran ayarları açılamadı."));

// Upstream has no Polish locale; the edition's additions still carry Polish.
constexpr Msg with_polish(Msg message, const char* text) { message.v[unsigned(Lang::en)] = text; return message; }
inline constexpr auto enable_pl = with_polish(enable,"Włącz 3D");
inline constexpr auto resolution_pl = with_polish(resolution,"Szerokość renderowania na oko");
inline constexpr auto display_settings_pl = with_polish(display_settings,"Ustawienia ekranu");
inline constexpr auto no_limits_pl = with_polish(no_limits,"Brak limitów głębi. Oba obrazy są identyczne.");
inline constexpr auto zero_limits_pl = with_polish(zero_limits,"Przy tych limitach głębi oba obrazy są identyczne.");
inline constexpr auto no_support_pl = with_polish(no_support,"Głębia sceny nie jest skończona. Oba obrazy są identyczne.");
inline constexpr auto rectified_pl = with_polish(rectified,"3D prostuje ten obiektyw do widoku perspektywicznego.");
inline constexpr auto allocation_failed_pl = with_polish(allocation_failed,"Nie można przydzielić pamięci dla widoku 3D.");
inline constexpr auto declaration_failed_pl = with_polish(declaration_failed,"Nie można zadeklarować widoku 3D.");
inline constexpr auto session_required_pl = with_polish(session_required,"3D wymaga sesji Stereo KWin.");
inline constexpr auto placement_failed_pl = with_polish(placement_failed,"Nie można umieścić widoku 3D.");
inline constexpr auto pixel_format_pl = with_polish(pixel_format,"Format pikseli tego okna nie obsługuje 3D.");
inline constexpr auto settings_failed_pl = with_polish(settings_failed,"Nie można otworzyć ustawień ekranu.");
}  // namespace spirula::i18n::msg::stereo
#include "i18n/EndCatalog.h"
