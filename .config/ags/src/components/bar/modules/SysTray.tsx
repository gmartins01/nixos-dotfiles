import { bind, Variable, Gio, Binding } from "astal";
import AstalTray from 'gi://AstalTray?version=0.1';
import { Gdk, Gtk, Widget } from 'astal/gtk3';
import { isPrimaryClick, isSecondaryClick } from "../../../lib/events/mouse";

interface MenuEntryProps {
    item: AstalTray.TrayItem;
    child?: JSX.Element;
}


type BarBoxChild = {
    component: JSX.Element;
    isVisible?: boolean;
    isVis?: Binding<boolean>;
    isBox?: boolean;
    boxClass: string;
    tooltip_text?: string | Binding<string>;
} & ({ isBox: true; props: Widget.EventBoxProps } | { isBox?: false; props: Widget.ButtonProps });

const systray = AstalTray.get_default();

const createMenu = (menuModel: Gio.MenuModel, actionGroup: Gio.ActionGroup | null): Gtk.Menu => {
    const menu = Gtk.Menu.new_from_model(menuModel);
    menu.insert_action_group('dbusmenu', actionGroup);

    return menu;
};

const MenuDefaultIcon = ({ item }: MenuEntryProps): JSX.Element => {
    return (
        <icon
            className={'systray-icon'}
            gicon={bind(item, 'gicon')}
            tooltipMarkup={bind(item, 'tooltipMarkup')}
        />
    );
};

const MenuEntry = ({ item, child }: MenuEntryProps): JSX.Element => {
    let menu: Gtk.Menu;

    const entryBinding = Variable.derive(
        [bind(item, 'menuModel'), bind(item, 'actionGroup')],
        (menuModel, actionGroup) => {
            if (menuModel === null) {
                return console.error(`Menu Model not found for ${item.id}`);
            }
            if (actionGroup === null) {
                return console.error(`Action Group not found for ${item.id}`);
            }

            menu = createMenu(menuModel, actionGroup);
        },
    );

    return (
        <button
            cursor={'pointer'}
            className={"systray-button"}
            onClick={(self, event) => {
                if (isPrimaryClick(event)) {
                    item.activate(0, 0);
                }

                if (isSecondaryClick(event)) {
                    menu?.popup_at_widget(self, Gdk.Gravity.NORTH, Gdk.Gravity.SOUTH, null);
                }

                //if (isMiddleClick(event)) {
                //    SystemUtilities.notify({ summary: 'App Name', body: item.id });
                //}
            }}
            onDestroy={() => {
                menu?.destroy();
                entryBinding.drop();
            }}
        >
            {child}
        </button>
    );
};

const SysTray = ():  JSX.Element  => {
    const isVis = Variable(false);

    const componentChildren = Variable.derive(
        [bind(systray, 'items')],
        (items) => {
            const filteredTray = items;//.filter(({ id }) => !ignored.includes(id) && id !== null);

            isVis.set(filteredTray.length > 0);

            return filteredTray.map((item) => {

                return (
                    <MenuEntry item={item}>
                        <MenuDefaultIcon item={item} />
                    </MenuEntry>
                );
            });
        },
    );

    const component = (
        <box
            className={'systray-container'}
            onDestroy={() => {
                isVis.drop();
                componentChildren.drop();
            }}
        >
            {componentChildren()}
        </box>
    );

    return component;
    // return {
    //     component,
    //     isVisible: true,
    //     boxClass: 'systray',
    //     isVis: bind(isVis),
    //     isBox: true,
    //     props: {},
    // };
};

export { SysTray };
